"! <p class="shorttext synchronized" lang="EN">Function that accepts results ITAB and returns an exception</p>
interface zif_bapi_to_exc_function public.

  "! <p class="shorttext synchronized" lang="EN">Applies this function to the given argument</p>
  "!
  "! @parameter i_input | <p class="shorttext synchronized" lang="EN">The BAPI return table</p>
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">The potential resulting exception instance</p>
  methods apply
            importing
              i_input type any table
            returning
              value(r_val) type ref to cx_root.

endinterface.
