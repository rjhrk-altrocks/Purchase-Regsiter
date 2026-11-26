@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'tax'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TAX
  as select from    I_OperationalAcctgDocItem as _Item

    left outer join I_OperationalAcctgDocItem as _TaxJIC on  _TaxJIC.AccountingDocument           = _Item.AccountingDocument
                                                         and _TaxJIC.CompanyCode                  = _Item.CompanyCode
                                                         and _TaxJIC.FiscalYear                   = _Item.FiscalYear
                                                         and _TaxJIC.TaxItemAcctgDocItemRef       = _Item.TaxItemAcctgDocItemRef
                                                         and _TaxJIC.AccountingDocumentItemType   = 'T'
                                                         and _TaxJIC.TransactionTypeDetermination = 'JIC'

    left outer join I_OperationalAcctgDocItem as _TaxJIS on  _TaxJIS.AccountingDocument           = _Item.AccountingDocument
                                                         and _TaxJIS.CompanyCode                  = _Item.CompanyCode
                                                         and _TaxJIS.FiscalYear                   = _Item.FiscalYear
                                                         and _TaxJIS.TaxItemAcctgDocItemRef       = _Item.TaxItemAcctgDocItemRef
                                                         and _TaxJIS.AccountingDocumentItemType   = 'T'
                                                         and _TaxJIS.TransactionTypeDetermination = 'JIS'

    left outer join I_OperationalAcctgDocItem as _TaxJII on  _TaxJII.AccountingDocument           = _Item.AccountingDocument
                                                         and _TaxJII.CompanyCode                  = _Item.CompanyCode
                                                         and _TaxJII.FiscalYear                   = _Item.FiscalYear
                                                         and _TaxJII.TaxItemAcctgDocItemRef       = _Item.TaxItemAcctgDocItemRef
                                                         and _TaxJII.AccountingDocumentItemType   = 'T'
                                                         and _TaxJII.TransactionTypeDetermination = 'JII'
  //composition of target_data_source_name as _association_name
{
  key _Item.CompanyCode,
  key _Item.AccountingDocument,
  key _Item.FiscalYear,
  key _Item.AccountingDocumentItem,
      _Item.TransactionCurrency,
      _Item.TaxItemAcctgDocItemRef,

      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      cast(
        case
          when _Item.TaxCode = 'N0' or _Item.TaxCode = 'N1' or _Item.TaxCode = 'N2' or _Item.TaxCode = 'N6' or _Item.TaxCode = 'N7' or _Item.TaxCode = 'N8'
            then cast(_Item.NonDcblTaxAbsltAmtInCoCodeCrcy as abap.dec( 23, 2 ) ) / 2
          else
           cast( _TaxJIC.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2))
        end
        as abap.dec(23,2)
      )                                                                   as CGST_AMT,

      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      cast(
        case
          when _Item.TaxCode = 'N0' or _Item.TaxCode = 'N1' or _Item.TaxCode = 'N2' or _Item.TaxCode = 'N6' or _Item.TaxCode = 'N7' or _Item.TaxCode = 'N8'
            then cast(_Item.NonDcblTaxAbsltAmtInCoCodeCrcy as abap.dec( 23, 2 ) ) / 2
          else
           cast( _TaxJIS.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2))
        end
        as abap.dec(23,2)
      )                                                                   as SGST_AMT,

      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      cast(
      case when _Item.TaxCode = 'N3' or _Item.TaxCode = 'N4' or _Item.TaxCode = 'N9' or _Item.TaxCode = 'N5' or _Item.TaxCode = 'NI'
      then cast(_Item.NonDcblTaxAbsltAmtInCoCodeCrcy as abap.dec( 23, 2 ) )
      else
      cast( _TaxJII.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2))  end
         as abap.dec(23,2)
      )                                                                   as IGST_AMT,

      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      case when substring( _Item.TaxCode, 1, 1 ) = 'N'
      then cast( _Item.OriginalTaxAbsoluteBaseAmount as abap.dec( 23, 2 ))
      else
        cast(_Item.AmountInTransactionCurrency as abap.dec( 23 , 2 )) end as BaseAmount
      //  _association_name // Make association public
}
where
  _Item.AccountingDocumentItemType = 'T'
