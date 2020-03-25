#include <acc_prof.h>
#include <stdio.h>
void prof_inc(acc_prof_info* prof_info, acc_event_info* event_info,
              acc_api_info* api_info) {
  printf("Event type %d file %s line %d func name %s %d %d region %d %d\n",
         prof_info->event_type, prof_info->src_file, prof_info->line_no,
         prof_info->func_name, prof_info->func_line_no, prof_info->func_end_line_no, prof_info->line_no, prof_info->end_line_no );



}
void acc_register_library(acc_prof_reg reg, acc_prof_reg unreg,
                          acc_prof_lookup lookup) {
  reg(acc_ev_compute_construct_start, prof_inc, acc_reg);
  reg(acc_ev_compute_construct_end, prof_inc, acc_reg);
}
int main() {
  #pragma acc parallel num_gangs( 4 )
    printf( "toto\n" );
  return 0;
}
