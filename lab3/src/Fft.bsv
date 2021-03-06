import Vector::*;

import FftCommon::*;
import Fifo::*;

interface Fft;
  method Action enq(Vector#(FftPoints, ComplexData) in);
  method ActionValue#(Vector#(FftPoints, ComplexData)) deq;
endinterface

(* synthesize *)
module mkFftCombinational(Fft);
  Fifo#(2, Vector#(FftPoints, ComplexData)) inFifo <- mkCFFifo;
  Fifo#(2, Vector#(FftPoints, ComplexData)) outFifo <- mkCFFifo;
  Vector#(NumStages, Vector#(BflysPerStage, Bfly4)) bfly <- replicateM(replicateM(mkBfly4));

  function Vector#(FftPoints, ComplexData) stage_f(StageIdx stage, Vector#(FftPoints, ComplexData) stage_in);
    Vector#(FftPoints, ComplexData) stage_temp, stage_out;
    for (FftIdx i = 0; i < fromInteger(valueOf(BflysPerStage)); i = i + 1)
    begin
      FftIdx idx = i * 4;
      Vector#(4, ComplexData) x;
      Vector#(4, ComplexData) twid;
      for (FftIdx j = 0; j < 4; j = j + 1 )
      begin
        x[j] = stage_in[idx+j];
        twid[j] = getTwiddle(stage, idx+j);
      end
      let y = bfly[stage][i].bfly4(twid, x);

      for(FftIdx j = 0; j < 4; j = j + 1 )
        stage_temp[idx+j] = y[j];
    end

    stage_out = permute(stage_temp);

    return stage_out;
  endfunction

  rule doFft;
    inFifo.deq;
    Vector#(4, Vector#(FftPoints, ComplexData)) stage_data;
    stage_data[0] = inFifo.first;

    for (StageIdx stage = 0; stage < 3; stage = stage + 1)
      stage_data[stage+1] = stage_f(stage, stage_data[stage]);
    outFifo.enq(stage_data[3]);
  endrule

  method Action enq(Vector#(FftPoints, ComplexData) in);
    inFifo.enq(in);
  endmethod

  method ActionValue#(Vector#(FftPoints, ComplexData)) deq;
    outFifo.deq;
    return outFifo.first;
  endmethod
endmodule

(* synthesize *)
module mkFftFolded(Fft);
  Fifo#(2, Vector#(FftPoints, ComplexData)) inFifo <- mkCFFifo;
  Fifo#(2, Vector#(FftPoints, ComplexData)) outFifo <- mkCFFifo;
  Reg#(Vector#(FftPoints, ComplexData))  sFifo <- mkReg(replicate(0));
  Reg#(Bit#(3)) eee <- mkReg(0);
  //Vector#(FftPoints, ComplexData) sxIn = replicate(0);
  Vector#(NumStages, Vector#(BflysPerStage, Bfly4)) bfly <- replicateM(replicateM(mkBfly4));
  StageIdx stagee = 0;
  // You can copy & modify the stage_f function in the combinational implementation.
  function Vector#(FftPoints, ComplexData) stage_f(StageIdx stage, Vector#(FftPoints, ComplexData) stage_in);
    Vector#(FftPoints, ComplexData) stage_temp, stage_out;
    for (FftIdx i = 0; i < fromInteger(valueOf(BflysPerStage)); i = i + 1)
    begin
      FftIdx idx = i * 4;
      Vector#(4, ComplexData) x;
      Vector#(4, ComplexData) twid;
      for (FftIdx j = 0; j < 4; j = j + 1 )
      begin
        x[j] = stage_in[idx+j];
        twid[j] = getTwiddle(stage, idx+j);
      end
      let y = bfly[stage][i].bfly4(twid, x);

      for(FftIdx j = 0; j < 4; j = j + 1 )
        stage_temp[idx+j] = y[j];
    end

    stage_out = permute(stage_temp);

    return stage_out;
  endfunction

  rule doFft if (True);
    Vector#(FftPoints, ComplexData) sxIn;
    if(eee==0)
    begin 
      sxIn = inFifo.first(); inFifo.deq(); 
    end
    else sxIn = sFifo;
    let sxOut = stage_f(eee, sxIn);
    if(eee==2)
      outFifo.enq(sxOut);
    else
      sFifo <= sxOut;
    eee <= ((eee==2) ? 0 : eee+1);
  endrule
/*
  rule doEntry if(eee==0);
    //TODO: Remove below two lines and Implement the rest of this module
    inFifo.deq;
    sFifo <= stage_f(stagee, inFifo.first);
    eee <= eee+1;
  endrule

  rule doCirculate if ((eee!=0) && (eee<2));
    sFifo <= stage_f(eee, sFifo);
    eee <= eee+1;
  endrule

  rule doExit if (eee==2);
    outFifo.enq(stage_f(eee, sFifo));
    eee <= 0;
  endrule
*/
  method Action enq(Vector#(FftPoints, ComplexData) in);
    inFifo.enq(in);
  endmethod

  method ActionValue#(Vector#(FftPoints, ComplexData)) deq;
    outFifo.deq;
    return outFifo.first;
  endmethod
endmodule

(* synthesize *)
module mkFftPipelined(Fft);
  Fifo#(2, Vector#(FftPoints, ComplexData)) inFifo <- mkCFFifo;
  Fifo#(2, Vector#(FftPoints, ComplexData)) outFifo <- mkCFFifo;
  Fifo#(2, Vector#(FftPoints, ComplexData)) midFifo1 <- mkCFFifo;
  Fifo#(2, Vector#(FftPoints, ComplexData)) midFifo2 <- mkCFFifo;
  
  Vector#(NumStages, Vector#(BflysPerStage, Bfly4)) bfly <- replicateM(replicateM(mkBfly4));

  // You can copy & modify the stage_f function in the combinational implementation.
  function Vector#(FftPoints, ComplexData) stage_f(StageIdx stage, Vector#(FftPoints, ComplexData) stage_in);
    Vector#(FftPoints, ComplexData) stage_temp, stage_out;
    for (FftIdx i = 0; i < fromInteger(valueOf(BflysPerStage)); i = i + 1)
    begin
      FftIdx idx = i * 4;
      Vector#(4, ComplexData) x;
      Vector#(4, ComplexData) twid;
      for (FftIdx j = 0; j < 4; j = j + 1 )
      begin
        x[j] = stage_in[idx+j];
        twid[j] = getTwiddle(stage, idx+j);
      end
      let y = bfly[stage][i].bfly4(twid, x);

      for(FftIdx j = 0; j < 4; j = j + 1 )
        stage_temp[idx+j] = y[j];
    end

    stage_out = permute(stage_temp);

    return stage_out;
  endfunction

  rule first if(inFifo.notEmpty()&&midFifo1.notFull());
    inFifo.deq();
    midFifo1.enq(stage_f(0, inFifo.first()));
  endrule

  rule second if(midFifo1.notEmpty()&&midFifo2.notFull());
    midFifo1.deq();
    midFifo2.enq(stage_f(1, midFifo1.first()));
  endrule

  rule third if(midFifo2.notEmpty()&&outFifo.notFull());
    midFifo2.deq();
    outFifo.enq(stage_f(2,midFifo2.first()));
  endrule

  method Action enq(Vector#(FftPoints, ComplexData) in);
    inFifo.enq(in);
  endmethod
    
  method ActionValue#(Vector#(FftPoints, ComplexData)) deq;
    outFifo.deq;
    return outFifo.first;
  endmethod
endmodule

interface SuperFoldedFft#(numeric type radix);
  method ActionValue#(Vector#(FftPoints, ComplexData)) deq;
  method Action enq(Vector#(FftPoints, ComplexData) in);
endinterface

module mkFftSuperFolded(SuperFoldedFft#(radix)) provisos(Div#(TDiv#(FftPoints, 4), radix, times), Mul#(radix, times, TDiv#(FftPoints, 4)));
  Fifo#(2, Vector#(FftPoints, ComplexData)) inFifo <- mkCFFifo;
  Fifo#(2, Vector#(FftPoints, ComplexData)) outFifo <- mkCFFifo;
  Vector#(radix, Bfly4) bfly <- replicateM(mkBfly4);

  // You can copy & modify the stage_f function in the combinational implementation.
  // or divide stage_f function into doFft rule with appropriate modification.

  rule doFft;
    //TODO: Remove below two lines Implement the rest of this module
	outFifo.enq(inFifo.first);
	inFifo.deq;
  endrule

  method Action enq(Vector#(FftPoints, ComplexData) in);
    inFifo.enq(in);
  endmethod

  method ActionValue#(Vector#(FftPoints, ComplexData)) deq;
    outFifo.deq;
    return outFifo.first;
  endmethod
endmodule

function Fft getFft(SuperFoldedFft#(radix) f);
  return (interface Fft;
    method enq = f.enq;
    method deq = f.deq;
  endinterface);
endfunction
