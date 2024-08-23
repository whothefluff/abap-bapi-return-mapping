# abap-bapiret-mapping

Convert BAPI return errors of common types like BAPIRET2, BAPIRET1, BAPIRETURN, BAPIRETURN1, BAPIRETC, etc. into class-based exceptions

## Use

Reuse class _ZCL_BAPIRET_TO_BAPI_E_FUNCTION_ (which returns a child of ZCX_NO_CHECK with a getter for all messages of type error):
```abap
data(bapi_error_msg) = new zcl_free_message( `Creation of x failed` ).

call function 'BAPI_*'
  tables
    return = return.

data(e) = new zcl_bapiret_to_bapi_e_function( bapi_error_msg )->apply( return ).

if e is bound.

  raise exception e.

endif.
```
```abap
data(to_bapi_e) = new zcl_bapiret_to_bapi_e_function( ).

call function 'BAPI_CREATE*'
  tables
    return = return.

data(e) = to_bapi_e->apply( return ).

if e is bound.

  data(errors) = e->errors( ).

endif.
```
Or create your own implementation of _ZIF_BAPI_TO_EXC_FUNCTION_.