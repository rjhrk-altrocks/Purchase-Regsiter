@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LIST OF TAX CODE'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TAXCODE
  as select from I_TaxCode as _Item
  //composition of target_data_source_name as _association_name
{
  key TaxCode,
      case
        when _Item.TaxCode =  'N1' or _Item.TaxCode = 'N3' or _Item.TaxCode =  'N6'
      then cast('0.05' as abap.dec( 2, 2 ))
      //        then 5 / 100
        when _Item.TaxCode =  'N2' or _Item.TaxCode =  'N2' or _Item.TaxCode =  'N7'
       then cast('0.18' as abap.dec( 2, 2 ))
      //       then 18 / 100
        end as TaxPer
      //  _association_name // Make association public
      //            when _Item.TaxCode =  'N1' then 'CGST 2.5% '
      //      when _Item.TaxCode =  'N2' then 'CGST 9% '
      //      when _Item.TaxCode =  'N6' then 'CGST 2.5% '
      //      when _Item.TaxCode =  'N7' then 'CGST 9% '

}
