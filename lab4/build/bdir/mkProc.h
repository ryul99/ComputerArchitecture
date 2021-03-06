/*
 * Generated by Bluespec Compiler, version 2014.07.A (build 34078, 2014-07-30)
 * 
 * On Tue May  8 18:31:49 KST 2018
 * 
 */

/* Generation options: */
#ifndef __mkProc_h__
#define __mkProc_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"
#include "mkCop.h"
#include "mkDMemory.h"
#include "mkIMemory.h"
#include "mkRFile.h"


/* Class declaration for the mkProc module */
class MOD_mkProc : public Module {
 
 /* Clock handles */
 private:
  tClock __clk_handle_0;
 
 /* Clock gate handles */
 public:
  tUInt8 *clk_gate[0];
 
 /* Instantiation parameters */
 public:
 
 /* Module state */
 public:
  MOD_Reg<tUInt8> INST_condFlag;
  MOD_mkCop INST_cop;
  MOD_mkDMemory INST_dMem;
  MOD_Reg<tUWide> INST_e2m;
  MOD_Reg<tUWide> INST_f2e;
  MOD_mkIMemory INST_iMem;
  MOD_Reg<tUWide> INST_m2w;
  MOD_Reg<tUInt64> INST_pc;
  MOD_mkRFile INST_rf;
  MOD_Reg<tUInt8> INST_stage;
  MOD_Reg<tUInt8> INST_stat;
  MOD_Reg<tUInt8> INST_statRedirect_data_0_dummy2_0;
  MOD_Reg<tUInt8> INST_statRedirect_data_0_dummy2_1;
  MOD_Wire<tUInt8> INST_statRedirect_data_0_dummy_0_0;
  MOD_Wire<tUInt8> INST_statRedirect_data_0_dummy_0_1;
  MOD_Wire<tUInt8> INST_statRedirect_data_0_dummy_1_0;
  MOD_Wire<tUInt8> INST_statRedirect_data_0_dummy_1_1;
  MOD_Wire<tUInt8> INST_statRedirect_data_0_lat_0;
  MOD_Wire<tUInt8> INST_statRedirect_data_0_lat_1;
  MOD_Reg<tUInt8> INST_statRedirect_data_0_rl;
  MOD_Reg<tUInt8> INST_statRedirect_deqP_dummy2_0;
  MOD_Reg<tUInt8> INST_statRedirect_deqP_dummy2_1;
  MOD_Wire<tUInt8> INST_statRedirect_deqP_dummy_0_0;
  MOD_Wire<tUInt8> INST_statRedirect_deqP_dummy_0_1;
  MOD_Wire<tUInt8> INST_statRedirect_deqP_dummy_1_0;
  MOD_Wire<tUInt8> INST_statRedirect_deqP_dummy_1_1;
  MOD_Wire<tUInt8> INST_statRedirect_deqP_lat_0;
  MOD_Wire<tUInt8> INST_statRedirect_deqP_lat_1;
  MOD_Reg<tUInt8> INST_statRedirect_deqP_rl;
  MOD_Reg<tUInt8> INST_statRedirect_enqP_dummy2_0;
  MOD_Reg<tUInt8> INST_statRedirect_enqP_dummy2_1;
  MOD_Wire<tUInt8> INST_statRedirect_enqP_dummy_0_0;
  MOD_Wire<tUInt8> INST_statRedirect_enqP_dummy_0_1;
  MOD_Wire<tUInt8> INST_statRedirect_enqP_dummy_1_0;
  MOD_Wire<tUInt8> INST_statRedirect_enqP_dummy_1_1;
  MOD_Wire<tUInt8> INST_statRedirect_enqP_lat_0;
  MOD_Wire<tUInt8> INST_statRedirect_enqP_lat_1;
  MOD_Reg<tUInt8> INST_statRedirect_enqP_rl;
 
 /* Constructor */
 public:
  MOD_mkProc(tSimStateHdl simHdl, char const *name, Module *parent);
 
 /* Symbol init methods */
 private:
  void init_symbols_0();
 
 /* Reset signal definitions */
 private:
  tUInt8 PORT_RST_N;
 
 /* Port definitions */
 public:
  tUWide PORT_cpuToHost;
 
 /* Publicly accessible definitions */
 public:
  tUInt8 DEF_cop_started____d22;
  tUInt8 DEF_upd__h12334;
  tUInt8 DEF_upd__h13870;
  tUInt8 DEF_upd__h13928;
  tUInt8 DEF_statRedirect_deqP_dummy2_1__h12454;
  tUInt8 DEF_statRedirect_deqP_dummy2_0__h12441;
  tUInt8 DEF_statRedirect_enqP_dummy2_1__h13896;
  tUInt8 DEF_statRedirect_enqP_dummy2_0__h12260;
  tUInt8 DEF_y__h12487;
  tUInt8 DEF_x__h12486;
  tUInt8 DEF_IF_statRedirect_enqP_lat_0_whas__0_THEN_statRe_ETC___d13;
 
 /* Local definitions */
 private:
  tUWide DEF_m2w___d705;
  tUWide DEF_e2m___d590;
  tUWide DEF_f2e__h8705;
  tUWide DEF_iMem_req_pc_9___d30;
  tUInt64 DEF_pc__h6245;
  tUInt8 DEF_statRedirect_data_0_rl__h1678;
  tUWide DEF_e2m_90_BITS_262_TO_130___d666;
  tUWide DEF_e2m_90_BITS_193_TO_66___d608;
  tUWide DEF_IF_e2m_90_BITS_538_TO_535_91_EQ_4_92_OR_e2m_90_ETC___d628;
  tUWide DEF_e2m_90_BITS_193_TO_130_09_CONCAT_IF_e2m_90_BIT_ETC___d627;
  tUInt8 DEF_IF_statRedirect_data_0_lat_0_whas_THEN_statRed_ETC___d6;
  tUWide DEF_IF_f2e_59_BITS_79_TO_76_60_EQ_0b1_62_THEN_12_E_ETC___d580;
  tUWide DEF_IF_f2e_59_BITS_79_TO_76_60_EQ_0b1_62_OR_f2e_59_ETC___d579;
  tUWide DEF_e2m_90_BITS_538_TO_535_91_CONCAT_e2m_90_BIT_53_ETC___d684;
  tUWide DEF_e2m_90_BIT_528_48_CONCAT_IF_e2m_90_BIT_528_48__ETC___d683;
  tUWide DEF_NOT_f2e_59_BITS_79_TO_76_60_EQ_0b1_62_10_AND_N_ETC___d541;
  tUWide DEF_NOT_f2e_59_BITS_79_TO_76_60_EQ_0b1_62_10_AND_N_ETC___d578;
  tUWide DEF_e2m_90_BIT_522_51_CONCAT_IF_e2m_90_BIT_522_51__ETC___d654;
  tUWide DEF_e2m_90_BIT_457_11_CONCAT_IF_e2m_90_BIT_457_11__ETC___d682;
  tUWide DEF_NOT_f2e_59_BITS_79_TO_76_60_EQ_0b1_62_10_AND_N_ETC___d553;
  tUWide DEF_DONTCARE_CONCAT_IF_f2e_59_BITS_79_TO_76_60_EQ__ETC___d577;
  tUWide DEF_e2m_90_BIT_392_55_CONCAT_IF_e2m_90_BIT_392_55__ETC___d658;
  tUWide DEF_e2m_90_BITS_538_TO_535_91_EQ_4_92_OR_e2m_90_BI_ETC___d681;
  tUWide DEF_IF_f2e_59_BITS_79_TO_76_60_EQ_0b1_62_OR_f2e_59_ETC___d576;
  tUWide DEF_IF_e2m_90_BITS_538_TO_535_91_EQ_4_92_OR_e2m_90_ETC___d680;
  tUWide DEF_f2e_59_BITS_79_TO_76_60_EQ_0b1001_99_OR_NOT_IF_ETC___d575;
  tUWide DEF_NOT_f2e_59_BITS_79_TO_76_60_EQ_0b1001_99_19_CO_ETC___d574;
  tUWide DEF_NOT_e2m_90_BITS_538_TO_535_91_EQ_4_92_03_AND_N_ETC___d629;
 
 /* Rules */
 public:
  void RL_statRedirect_data_0_canon();
  void RL_statRedirect_enqP_canon();
  void RL_statRedirect_deqP_canon();
  void RL_doFetch();
  void RL_doExecute();
  void RL_doMemory();
  void RL_doWriteBack();
  void RL_upd_Stat();
  void RL_statHLT();
  void RL_statINS();
 
 /* Methods */
 public:
  tUWide METH_cpuToHost();
  tUInt8 METH_RDY_cpuToHost();
  void METH_hostToCpu(tUInt64 ARG_hostToCpu_startpc);
  tUInt8 METH_RDY_hostToCpu();
 
 /* Reset routines */
 public:
  void reset_RST_N(tUInt8 ARG_rst_in);
 
 /* Static handles to reset routines */
 public:
 
 /* Pointers to reset fns in parent module for asserting output resets */
 private:
 
 /* Functions for the parent module to register its reset fns */
 public:
 
 /* Functions to set the elaborated clock id */
 public:
  void set_clk_0(char const *s);
 
 /* State dumping routine */
 public:
  void dump_state(unsigned int indent);
 
 /* VCD dumping routines */
 public:
  unsigned int dump_VCD_defs(unsigned int levels);
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkProc &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkProc &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkProc &backing);
  void vcd_submodules(tVCDDumpType dt, unsigned int levels, MOD_mkProc &backing);
};

#endif /* ifndef __mkProc_h__ */
