function Bit#(1) and1(Bit#(1) a, Bit#(1) b);
  return a & b;
endfunction

function Bit#(1) or1(Bit#(1) a, Bit#(1) b);
  return a | b;
endfunction

function Bit#(1) not1(Bit#(1) a);
  return ~ a;
endfunction

function Bit#(1) multiplexer1(Bit#(1) sel, Bit#(1) a, Bit#(1) b);
    let ar = and1(a, not1(sel));
    let br = and1(b, sel);
    return or1(ar, br);
endfunction

function Bit#(64) multiplexer64(Bit#(1) sel, Bit#(64) a, Bit#(64) b);
    Bit#(64) aggregate;
    for(Integer i = 0; i < 64; i = i + 1)
        aggregate[i] = multiplexer1(sel, a[i], b[i]);
    return aggregate;
endfunction

typedef 64 N;
function Bit#(N) multiplexerN(Bit#(1) sel, Bit#(N) a, Bit#(N) b);
  return multiplexer_n(sel, a, b);
endfunction

//typedef 64 N; // Not needed
function Bit#(n) multiplexer_n(Bit#(1) sel, Bit#(n) a, Bit#(n) b);
    Bit#(n) r = 0;
    let valn = valueOf(n);
    for(Integer i = 0; i < valn; i = i + 1)
        r[i] = multiplexer1(sel, a[i], b[i]);
    return r;
endfunction
