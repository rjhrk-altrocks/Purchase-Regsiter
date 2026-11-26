@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_ITEM
  as select from    I_OperationalAcctgDocItem      as _Item

    left outer join I_GLAccountText                as _GLText     on  _GLText.GLAccount = _Item.GLAccount
                                                                  and _GLText.Language  = 'E'
    left outer join I_OperationalAcctgDocItem      as _SupplierNo on  _SupplierNo.AccountingDocument     = _Item.AccountingDocument
                                                                  and _SupplierNo.CompanyCode            = _Item.CompanyCode
                                                                  and _SupplierNo.FiscalYear             = _Item.FiscalYear
                                                                  and _SupplierNo.AccountingDocumentItem = '001'

    left outer join I_Supplier                     as _Lfa1       on _Lfa1.Supplier = _SupplierNo.Supplier

    left outer join I_TaxCodeText                  as _TaxText    on  _TaxText.TaxCode  = _Item.TaxCode
                                                                  and _TaxText.Language = 'E'

    left outer join I_ProductDescription           as _Desc       on  _Desc.Product  = _Item.Product
                                                                  and _Desc.Language = 'E'

    left outer join I_Product                      as _Prod       on _Prod.Product = _Item.Product

    left outer join I_JournalEntry                 as _Jou        on  _Jou.AccountingDocument = _Item.AccountingDocument
                                                                  and _Jou.CompanyCode        = _Item.CompanyCode
                                                                  and _Jou.FiscalYear         = _Item.FiscalYear
  //                                                                  and _Jou.Ledger             = '0L'


  //    left outer join I_PurchaseOrderHistoryAPI01    as _prodhis    on  _prodhis.PurchaseOrder                 = _Item.PurchasingDocument
  //                                                                  and _prodhis.PurchaseOrderItem             = _Item.PurchasingDocumentItem
  //                                                                  and _prodhis.AccountAssignmentNumber       = '00'
  //                                                                  and _prodhis.PurchasingHistoryDocumentType = '2'
  //                                                                  and _prodhis.Material                      = _Item.Product

  //        right( I_OperationalAcctgDocItem.OriginalReferenceDocument, 4 ) as REF_YEAR



    left outer join I_PurchaseOrderItemAPI01       as _puritem    on  _puritem.PurchaseOrder     = _Item.PurchasingDocument
                                                                  and _puritem.PurchaseOrderItem = _Item.PurchasingDocumentItem



    left outer join I_PurchaseOrderAPI01           as _purchase   on _purchase.PurchaseOrder = _Item.PurchasingDocument

    left outer join I_PurchaseRequisitionItemAPI01 as _purreq     on  _purreq.PurchaseRequisition     = _puritem.PurchaseRequisition
                                                                  and _purreq.PurchaseRequisitionItem = _puritem.PurchaseRequisitionItem



    left outer join I_ProductTypeText              as _prdtype    on  _prdtype.ProductType = _Prod.ProductType
                                                                  and _prdtype.Language    = 'E'



    left outer join I_ProductGroupText_2           as _PRDGRP     on  _PRDGRP.ProductGroup = _Prod.ProductGroup
                                                                  and _PRDGRP.Language     = 'E'


    left outer join I_OperationalAcctgDocItem      as _TaxJIC     on  _TaxJIC.AccountingDocument           = _Item.AccountingDocument
                                                                  and _TaxJIC.CompanyCode                  = _Item.CompanyCode
                                                                  and _TaxJIC.FiscalYear                   = _Item.FiscalYear
                                                                  and _TaxJIC.TaxItemAcctgDocItemRef       = _Item.TaxItemAcctgDocItemRef
                                                                  and _TaxJIC.AccountingDocumentItemType   = 'T'
                                                                  and _TaxJIC.TransactionTypeDetermination = 'JIC'

    left outer join I_OperationalAcctgDocItem      as _TaxJIS     on  _TaxJIS.AccountingDocument           = _Item.AccountingDocument
                                                                  and _TaxJIS.CompanyCode                  = _Item.CompanyCode
                                                                  and _TaxJIS.FiscalYear                   = _Item.FiscalYear
                                                                  and _TaxJIS.TaxItemAcctgDocItemRef       = _Item.TaxItemAcctgDocItemRef
                                                                  and _TaxJIS.AccountingDocumentItemType   = 'T'
                                                                  and _TaxJIS.TransactionTypeDetermination = 'JIS'

    left outer join I_OperationalAcctgDocItem      as _TaxJII     on  _TaxJII.AccountingDocument           = _Item.AccountingDocument
                                                                  and _TaxJII.CompanyCode                  = _Item.CompanyCode
                                                                  and _TaxJII.FiscalYear                   = _Item.FiscalYear
                                                                  and _TaxJII.TaxItemAcctgDocItemRef       = _Item.TaxItemAcctgDocItemRef
                                                                  and _TaxJII.AccountingDocumentItemType   = 'T'
                                                                  and _TaxJII.TransactionTypeDetermination = 'JII'
  //
  //    left outer join ZI_TAX                         as _TaxT       on  _TaxT.AccountingDocument     = _Item.AccountingDocument
  //                                                                  and _TaxT.CompanyCode            = _Item.CompanyCode
  //                                                                  and _TaxT.FiscalYear             = _Item.FiscalYear
  //    //                                                                  and _TaxT.AccountingDocumentItem = _Item.AccountingDocumentItem
  //                                                                  and _TaxT.TaxItemAcctgDocItemRef = _Item.TaxItemAcctgDocItemRef

    left outer join I_OperationalAcctgDocItem      as _TaxWIT     on  _TaxWIT.AccountingDocument           = _Item.AccountingDocument
                                                                  and _TaxWIT.CompanyCode                  = _Item.CompanyCode
                                                                  and _TaxWIT.FiscalYear                   = _Item.FiscalYear
    //                                                                  and _TaxWIT.TaxItemAcctgDocItemRef       = _Item.TaxItemAcctgDocItemRef
    //                                                                  and _TaxJII.AccountingDocumentItemType   = 'T'
                                                                  and _TaxWIT.TransactionTypeDetermination = 'WIT'

    left outer join I_OperationalAcctgDocItem      as _FRT        on  _FRT.AccountingDocument           = _Item.AccountingDocument
                                                                  and _FRT.CompanyCode                  = _Item.CompanyCode
                                                                  and _FRT.FiscalYear                   = _Item.FiscalYear
    //                                                                  and _FRT.TaxItemAcctgDocItemRef       = _Item.TaxItemAcctgDocItemRef
                                                                  and _FRT.TransactionTypeDetermination = 'FR1'

    left outer join I_OperationalAcctgDocItem      as _Round      on  _Round.AccountingDocument = _Item.AccountingDocument
                                                                  and _Round.CompanyCode        = _Item.CompanyCode
                                                                  and _Round.FiscalYear         = _Item.FiscalYear
    //                                                                  and _Round.TaxItemAcctgDocItemRef = _Item.TaxItemAcctgDocItemRef
                                                                  and _Round.GLAccount          = '0050040581'

    left outer join ZI_TAXCODE                     as _TaxCode    on _Item.TaxCode = _TaxCode.TaxCode
  //composition of target_data_source_name as _opr_item
  // inner join I_BuPaIdentification as_bup on _opr_item.Supplier =
{
  key _Item.CompanyCode,
  key _Item.AccountingDocument,
  key _Item.FiscalYear,
  key _Item.AccountingDocumentItem,
      _Item.Product,
      _Item.PurchasingDocument,
      _Item.PurchasingDocumentItem,
      _Item.Material,
      _Item.AccountingDocumentItemType,
      _Item.DocumentItemText,
      _Item.Plant,
      _Item.OriginalReferenceDocument,
      _Item.PostingDate,
      _Item.FiscalPeriod,
      _Item.AccountingDocumentType,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      _Item.TaxAmount,
      _Item.TransactionCurrency,
      _Item.DocumentDate,
      _Item.GLAccount,
      _GLText.GLAccountName,
      _Item.ChartOfAccounts,
      _Item.NetDueDate,
      _Item.InvoiceReference,
      _Item.IN_HSNOrSACCode,
      _Item.BaseUnit,
      @Aggregation.default: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'BaseUnit'} }
      case when _Item.TransactionTypeDetermination = 'FR1' then
      cast(0 as abap.quan( 15, 3 ))
      else
      _Item.Quantity end                                                   as Quantity,

      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      _Item.OriginalTaxBaseAmount,
      _Item.TaxCode,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      _Item.InvoiceAmtInCoCodeCrcy,
      _Item.CompanyCodeCurrency,
      _SupplierNo.Supplier,
      _Item._Supplier.SupplierAccountGroup,
      _Desc.ProductDescription,
      _Prod.ProductType,
      _Prod.ProductGroup,
      _Lfa1.SupplierName,
      _Lfa1.TaxNumber3                                                     as SupplierGST,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      case when substring( _Item.TaxCode, 1, 1 ) = 'N'
      then _Item.OriginalTaxAbsoluteBaseAmount
      else
        _Item.AmountInTransactionCurrency end                              as AmountInTransactionCurrency,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      _Item.TaxBaseAmountInTransCrcy,

      //_prodhis.PostingDate,
      //      _prodhis.ReferenceDocumentFiscalYear,
      //      _prodhis.ReferenceDocument,
      //      _prodhis.ReferenceDocumentItem,
      _purchase.IncotermsClassification,
      _purchase.IncotermsLocation1,
      //_purchase.PurchaseOrder,
      _purchase.PurchasingGroup,
      _purchase.PurchasingOrganization,
      //_puritem.PurchaseOrderItem,
      _purreq.PurchaseRequisition,
      _purreq.CreationDate,
      _purreq.PurchaseRequisitionItem,
      _purreq.YY1_DepartmentNamePR_PRI,
      _purreq.CreatedByUser,
      _prdtype.MaterialTypeName,
      _Item.BusinessPlace,
      _PRDGRP.ProductGroupName,
      _PRDGRP.ProductGroupText,


      case
      when _Item.TaxCode =  'C0' then 'SGST 0% '
      when _Item.TaxCode =  'C3' then 'SGST 1.5% '
      when _Item.TaxCode =  'C5' then 'SGST 2.5% '
      when _Item.TaxCode =  'C8' then 'SGST 9% '
      when _Item.TaxCode =  'S3' then 'SGST 1.5% '
      when _Item.TaxCode =  'S5' then 'SGST 2.5% '
      when _Item.TaxCode =  'S8' then 'SGST 9% '
      when _Item.TaxCode =  'V2' then 'SGST 20% '
      when _Item.TaxCode =  'N0' then 'SGST 0% '
      when _Item.TaxCode =  'N1' then 'SGST 2.5% '
      when _Item.TaxCode =  'N2' then 'SGST 9% '
      when _Item.TaxCode =  'N6' then 'SGST 2.5% '
      when _Item.TaxCode =  'N7' then 'SGST 9% '
      end                                                                  as SGST_RATE,

      case
      when _Item.TaxCode =  'C0' then 'CGST 0% '
      when _Item.TaxCode =  'C3' then 'CGST 1.5% '
      when _Item.TaxCode =  'C5' then 'CGST 2.5% '
      when _Item.TaxCode =  'C8' then 'CGST 9% '
      when _Item.TaxCode =  'S3' then 'CGST 1.5% '
      when _Item.TaxCode =  'S5' then 'CGST 2.5% '
      when _Item.TaxCode =  'S8' then 'CGST 9% '
      when _Item.TaxCode =  'V2' then 'CGST 20% '
      when _Item.TaxCode =  'N0' then 'CGST 0% '
      when _Item.TaxCode =  'N1' then 'CGST 2.5% '
      when _Item.TaxCode =  'N2' then 'CGST 9% '
      when _Item.TaxCode =  'N6' then 'CGST 2.5% '
      when _Item.TaxCode =  'N7' then 'CGST 9% '
      end                                                                  as CGST_RATE,

      case
      when _Item.TaxCode =  'I0' then 'IGST 0% '
      when _Item.TaxCode =  'I3' then 'IGST 3% '
      when _Item.TaxCode =  'I5' then 'IGST 5% '
      when _Item.TaxCode =  'I8' then 'IGST 18% '
      when _Item.TaxCode =  'K1' then 'IGST 18% '
      when _Item.TaxCode =  'N3' then 'IGST 5% '
      when _Item.TaxCode =  'N4' then 'IGST 18% '
      when _Item.TaxCode =  'N5' then 'IGST 0% '
      when _Item.TaxCode =  'N9' then 'IGST 5% '
      when _Item.TaxCode =  'NI' then 'IGST 18% '
      when _Item.TaxCode =  'R3' then 'IGST 3% '
      when _Item.TaxCode =  'R5' then 'IGST 5% '
      when _Item.TaxCode =  'R8' then 'IGST 18% '
      when _Item.TaxCode =  'V1' then 'IGST 40% '

      end                                                                  as IGST_RATE,

      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      cast(
        case
          when (_Item.TaxCode = 'N0' or
          _Item.TaxCode = 'N1' or
          _Item.TaxCode = 'N2' or
          _Item.TaxCode = 'N6' or
          _Item.TaxCode = 'N7' or
          _Item.TaxCode = 'N8') and _Item.TransactionTypeDetermination <> 'FR1'
            then ( cast(_Item.OriginalTaxAbsoluteBaseAmount as abap.dec( 23, 2 ) ) * _TaxCode.TaxPer ) / 2
            when _Item.TransactionTypeDetermination = 'FR1'
            then cast( 0 as abap.dec(23,2))
          else
           cast( _TaxJIC.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2))
        end
        as abap.dec(23,2)
      )                                                                    as CGST_AMT,



      //      case when _Item.TaxCode = 'AO'
      //      or _Item.TaxCode = 'N0'
      //      then cast (cast(_Item.AmountInTransactionCurrency
      //      as abap.fltp) * 0.00 as abap.dec( 3, 2 ) )
      //      when _Item.TaxCode = 'AD'
      //      or _Item.TaxCode = 'N4'
      //      or _Item.TaxCode = 'BD'
      //      then cast (cast(_Item.AmountInTransactionCurrency
      //      as abap.fltp) * 0.14 as abap.dec( 3, 2 ) )
      //      when _Item.TaxCode = 'AA'
      //      or _Item.TaxCode = 'N1'
      //      or _Item.TaxCode = 'BA'
      //      then cast (cast(_Item.AmountInTransactionCurrency
      //      as abap.fltp) * 0.025 as abap.dec( 3, 2 ) )
      //      when _Item.TaxCode = 'AB'
      //      or _Item.TaxCode = 'N2'
      //      or _Item.TaxCode = 'BB'
      //      then cast (cast(_Item.AmountInTransactionCurrency
      //      as abap.fltp) * 0.06 as abap.dec( 3, 2 ) )
      //      when _Item.TaxCode = 'AC'
      //      or _Item.TaxCode = 'N3'
      //      or _Item.TaxCode = 'AK'
      //      or _Item.TaxCode = 'BC'
      //      then cast (cast(_Item.AmountInTransactionCurrency
      //      as abap.fltp) * 0.09 as abap.dec( 3, 2 ) )
      //      end                                                                  as CGST_AMT1,



      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      cast(
        case
          when ( _Item.TaxCode = 'N0'
                or _Item.TaxCode = 'N1'
                or _Item.TaxCode = 'N2'
                or _Item.TaxCode = 'N6'
                or _Item.TaxCode = 'N7'
                or _Item.TaxCode = 'N8' ) and _Item.TransactionTypeDetermination <> 'FR1'
      // then cast(_Item.NonDcblTaxAbsltAmtInCoCodeCrcy as abap.dec( 23, 2 ) ) / 2
            then (( cast(_Item.OriginalTaxAbsoluteBaseAmount as abap.dec( 23, 2 ) ) * _TaxCode.TaxPer ) / 2 )
            when _Item.TransactionTypeDetermination = 'FR1'
            then cast( 0 as abap.dec(23,2))
          else
           cast( _TaxJIC.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2))
        end
        as abap.dec(23,2)
      )                                                                    as SGST_AMT,

      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      case when ( _Item.TaxCode = 'N3'
                or _Item.TaxCode = 'N4'
                or _Item.TaxCode = 'N9'
                or _Item.TaxCode = 'N5'
                or _Item.TaxCode = 'NI') and _Item.TransactionTypeDetermination <> 'FR1'
      // then _Item.NonDcblTaxAbsltAmtInCoCodeCrcy
      then ( cast(_Item.OriginalTaxAbsoluteBaseAmount as abap.dec( 23, 2 ) ) * _TaxCode.TaxPer )
       when _Item.TransactionTypeDetermination = 'FR1'
            then cast( 0 as abap.dec(23,2))
      else
      cast(  _TaxJII.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2))  end as IGST_AMT,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast(

        coalesce(

          cast(
            case
              when ( _Item.TaxCode = 'N0' or _Item.TaxCode = 'N1'
                or _Item.TaxCode = 'N2' or _Item.TaxCode = 'N6'
                or _Item.TaxCode = 'N7' or _Item.TaxCode = 'N8' ) and _Item.TransactionTypeDetermination <> 'FR1'
      //              then cast( _Item.NonDcblTaxAbsltAmtInCoCodeCrcy as abap.dec(23,2) ) / 2
                then ( cast(_Item.OriginalTaxAbsoluteBaseAmount as abap.dec( 23, 2 ) ) * _TaxCode.TaxPer ) / 2
              when _Item.TransactionTypeDetermination = 'FR1'
                then cast( 0 as abap.dec(23,2))
              else cast( _TaxJIC.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2) )
            end
            as abap.dec(23,2)
          ),
          0
        )

        +

        coalesce(

          cast(
            case
              when ( _Item.TaxCode = 'N0' or _Item.TaxCode = 'N1'
                or _Item.TaxCode = 'N2' or _Item.TaxCode = 'N6'
                or _Item.TaxCode = 'N7' or _Item.TaxCode = 'N8' ) and _Item.TransactionTypeDetermination <> 'FR1'
      //              then cast( _Item.NonDcblTaxAbsltAmtInCoCodeCrcy as abap.dec(23,2) ) / 2
      then ( cast(_Item.OriginalTaxAbsoluteBaseAmount as abap.dec( 23, 2 ) ) * _TaxCode.TaxPer ) / 2
       when _Item.TransactionTypeDetermination = 'FR1'
                then cast( 0 as abap.dec(23,2))
              else cast( _TaxJIS.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2) )
            end
            as abap.dec(23,2)
          ),
          0
        )

        +

        coalesce(

          cast(
            case
              when ( _Item.TaxCode = 'N3' or _Item.TaxCode = 'N4'
                or _Item.TaxCode = 'N5' or _Item.TaxCode = 'N9'
                or _Item.TaxCode = 'NI' ) and _Item.TransactionTypeDetermination <> 'FR1'
      //              then cast( _Item.NonDcblTaxAbsltAmtInCoCodeCrcy as abap.dec(23,2) )
      then ( cast(_Item.OriginalTaxAbsoluteBaseAmount as abap.dec( 23, 2 ) ) * _TaxCode.TaxPer )
              when _Item.TransactionTypeDetermination = 'FR1'
      // then cast( _FRT.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2)) - cast(_Item.OriginalTaxAbsoluteBaseAmount as abap.dec( 23, 2 ) )
              then cast( 0 as abap.dec(23,2))
              else cast( _TaxJII.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2) )
            end
            as abap.dec(23,2)
          ),
          0
        )

      as abap.dec(23,2) )                                                  as TotalTax,

      @Semantics.amount.currencyCode: 'TransactionCurrency'

      cast(

      coalesce(

      cast(
      case
        when ( _Item.TaxCode = 'N0' or _Item.TaxCode = 'N1'
          or _Item.TaxCode = 'N2' or _Item.TaxCode = 'N6'
          or _Item.TaxCode = 'N7' or _Item.TaxCode = 'N8' ) and _Item.TransactionTypeDetermination <> 'FR1'
      //        then cast( _Item.NonDcblTaxAbsltAmtInCoCodeCrcy as abap.dec(23,2) ) / 2
      then ( cast(_Item.OriginalTaxAbsoluteBaseAmount as abap.dec( 23, 2 ) ) * _TaxCode.TaxPer ) / 2
      when _Item.TransactionTypeDetermination = 'FR1'
                then cast( 0 as abap.dec(23,2))
        else cast( _TaxJIC.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2) )
      end
      as abap.dec(23,2)
      ),
      0
      )

      +

      coalesce(

      cast(
      case
        when ( _Item.TaxCode = 'N0' or _Item.TaxCode = 'N1'
          or _Item.TaxCode = 'N2' or _Item.TaxCode = 'N6'
          or _Item.TaxCode = 'N7' or _Item.TaxCode = 'N8' ) and _Item.TransactionTypeDetermination <> 'FR1'
      //        then cast( _Item.NonDcblTaxAbsltAmtInCoCodeCrcy as abap.dec(23,2) ) / 2
      then ( cast(_Item.OriginalTaxAbsoluteBaseAmount as abap.dec( 23, 2 ) ) * _TaxCode.TaxPer ) / 2
      when _Item.TransactionTypeDetermination = 'FR1'
                then cast( 0 as abap.dec(23,2))
        else cast( _TaxJIS.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2) )
      end
      as abap.dec(23,2)
      ),
      0
      )

      +

      coalesce(

      cast(
      case
        when ( _Item.TaxCode = 'N3' or _Item.TaxCode = 'N4'
          or _Item.TaxCode = 'N5' or _Item.TaxCode = 'N9'
          or _Item.TaxCode = 'NI' ) and _Item.TransactionTypeDetermination <> 'FR1'
      //        then cast( _Item.NonDcblTaxAbsltAmtInCoCodeCrcy as abap.dec(23,2) )
      then ( cast(_Item.OriginalTaxAbsoluteBaseAmount as abap.dec( 23, 2 ) ) * _TaxCode.TaxPer )
      when _Item.TransactionTypeDetermination = 'FR1'
                then cast( 0 as abap.dec(23,2))
        else cast( _TaxJII.AbsltAmtInAdditionalCurrency1 as abap.dec(23,2) )
      end
      as abap.dec(23,2)
      ),
      0
      )
      +
      coalesce(
      cast(
      case
      when ( substring( _Item.TaxCode, 1, 1 ) = 'N' ) and _Item.TransactionTypeDetermination <> 'FR1'
      //      then cast( _Item.OriginalTaxAbsoluteBaseAmount as abap.dec(23,2) )
      then cast( _Item.OriginalTaxAbsoluteBaseAmount as abap.dec(23,2) )
      when _Item.TransactionTypeDetermination = 'FR1'
                then cast( 0 as abap.dec(23,2))
      else
      cast( _Item.AmountInTransactionCurrency as abap.dec(23,2) )
      end
      as abap.dec(23,2)
      ),
      0
      )

      as abap.dec(23,2) )                                                  as TotalAmount,
      //      cast(
      //          coalesce( _TaxT.CGST_AMT, 0 )
      //        + coalesce( _TaxT.SGST_AMT, 0 )
      //        + coalesce( _TaxT.IGST_AMT, 0 )
      //        + coalesce( _TaxT.BaseAmount, 0 )
      //        as abap.dec(23,2)
      //      )                                          as TotalAmount,
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      case
      // when _Item.TaxItemAcctgDocItemRef = '000001' then
      when _Item.TransactionTypeDetermination = 'FR1' then
      _FRT.AbsltAmtInAdditionalCurrency1
      end                                                                  as FreightAmount,


      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      case
      when _Item.TaxItemAcctgDocItemRef = '000001' then
      cast( _TaxWIT.AbsltAmtInAdditionalCurrency1 as abap.dec( 23, 2 ) )
      end                                                                  as TDSAMOUNT,

      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      case
      when _Item.TaxItemAcctgDocItemRef = '000001' then
      cast( _Round.AbsltAmtInAdditionalCurrency1 as abap.dec( 23, 2 ) )
      end                                                                  as RoundOff,



      _TaxText.TaxCodeName,

      _Jou.DocumentReferenceID,

      _Item.TransactionTypeDetermination,
      _Lfa1.Region

      //  _association_name // Make association public


}
where
      _Item.FinancialAccountType         != 'K'
  and

  (
      _Item.AccountingDocumentType       =  'RE'
    or

      _Item.AccountingDocumentType       =  'KR'
  )
  and

      _Item.AccountingDocumentItemType   != 'T'
  and

      _Jou.IsReversal                    =  ''
  and _Jou.IsReversed                    =  ''
  and _Item.TransactionTypeDetermination <> 'WIT'
  //  and _Item.TransactionTypeDetermination <> 'FR1'
  and _Item.TransactionTypeDetermination <> 'PRD'
  and _Item.GLAccount                    <> '0050040581'
//  and(
//       _Item.AccountingDocument           =  '5000000028'
//    or _Item.AccountingDocument           =  '5000000037'
//    or _Item.AccountingDocument           =  '5000000040'
//  )
