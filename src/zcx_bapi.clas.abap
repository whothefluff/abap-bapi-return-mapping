"! <p class="shorttext synchronized" lang="EN">Exception with BAPI return error details</p>
class zcx_bapi definition
               public
               inheriting from zcx_no_check
               create public.

  public section.

    types: begin of t_error,
             type type bapi_mtype,
             id type symsgid,
             number type symsgno,
             message type bapi_msg,
             log_no type balognr,
             log_msg_no type balmnr,
             message_v1 type symsgv,
             message_v2 type symsgv,
             message_v3 type symsgv,
             message_v4 type symsgv,
             parameter type bapi_param,
             row type bapi_line,
             field type bapi_fld,
             system type bapilogsys,
             code type bapi_rcode,
             component type bapi_comp,
           end of t_error,
           t_errors type standard table of zcx_bapi=>t_error with empty key
                                                             with non-unique sorted key ty components type.

    methods constructor
              importing
                i_errors type zcx_bapi=>t_errors
                i_t100_message type ref to if_t100_message optional
                i_previous like previous optional.

    methods errors
              returning
                value(r_val) type zcx_bapi=>t_errors.

  protected section.

    data an_error_list type zcx_bapi=>t_errors.

endclass.
class zcx_bapi implementation.

  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( i_t100_message = cond #( when i_t100_message is bound
                                                 then i_t100_message
                                                 else new zcl_text_symbol_message( 'BAPI errors. Details in list'(001) ) )
                        i_previous = i_previous ).

    me->an_error_list = i_errors.

  endmethod.
  method errors.

    r_val = me->an_error_list.

  endmethod.

endclass.
