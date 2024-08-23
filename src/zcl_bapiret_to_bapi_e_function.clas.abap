"! <p class="shorttext synchronized" lang="EN">BAPI return to class-based BAPI exception function</p>
class zcl_bapiret_to_bapi_e_function definition
                                     public
                                     create public.

  public section.

    interfaces: zif_bapi_to_exc_function.

    types: t_errors type zcx_bapi=>t_errors,
           t_error type line of zcl_bapiret_to_bapi_e_function=>t_errors.

  "! <p class="shorttext synchronized" lang="EN">Creates a function instance</p>
  "!
  "! @parameter i_exc_msg | <p class="shorttext synchronized" lang="EN">Use this message as the exception message</p>
    methods constructor
              importing
                i_exc_msg type ref to if_t100_message optional.

    methods apply
              importing
                i_input type any table
              returning
                value(r_val) type ref to zcx_bapi.

  protected section.

    methods map
              importing
                i_bapi_return_line type any
              returning
                value(r_val) type zcl_bapiret_to_bapi_e_function=>t_error.

    data an_exc_msg type ref to if_t100_message.

endclass.
class zcl_bapiret_to_bapi_e_function implementation.

  method apply.

    types error_types type standard table of bapi_mtype with empty key.

    data(mapped) = value me->t_errors( for <e> in i_input
                                       ( me->map( <e> ) ) ).

    data(error_types) = value error_types( ( 'X' )
                                           ( 'A' )
                                           ( 'E' ) ).

    data(errors) = value me->t_errors( for <error> in error_types
                                       ( lines of filter #( mapped using key ty where type eq <error> ) ) ).

    r_val = cond #( when errors is not initial
                    then new zcx_bapi( i_t100_message = me->an_exc_msg
                                       i_errors = errors )
                    else value #( ) ).

  endmethod.
  method zif_bapi_to_exc_function~apply.

    r_val = me->apply( i_input ).

  endmethod.
  method map.

    assign component 'CODE' of structure i_bapi_return_line to field-symbol(<code>) casting type bapi_rcode.

    assign component 'COMPONENT' of structure i_bapi_return_line to field-symbol(<component>) casting type bapi_comp.

    r_val = conv #( let unique_fields = value me->t_error( code = cond #( when <code> is assigned
                                                                          then <code> )
                                                           component = cond #( when <component> is assigned
                                                                               then <component> ) ) in
                    corresponding #( base ( unique_fields )
                                     i_bapi_return_line ) ).

  endmethod.
  method constructor.

    me->an_exc_msg = i_exc_msg.

  endmethod.

endclass.
