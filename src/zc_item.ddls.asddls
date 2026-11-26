@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_ITEM
  provider contract transactional_query
  as projection on ZI_ITEM
{
  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  key AccountingDocumentItem,
      Product,
      PurchasingDocument,
      PurchasingDocumentItem,
      Material,
      AccountingDocumentItemType,
      DocumentItemText,
      Plant,
      OriginalReferenceDocument,
      PostingDate,
      FiscalPeriod,
      AccountingDocumentType,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      TaxAmount,
      TransactionCurrency,
      DocumentDate,
      GLAccount,
      GLAccountName,
      ChartOfAccounts,
      NetDueDate,
      InvoiceReference,
      IN_HSNOrSACCode,
      BaseUnit,
      @Aggregation.default: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'BaseUnit'} }
      Quantity,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      OriginalTaxBaseAmount,
      TaxCode,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      InvoiceAmtInCoCodeCrcy,
      CompanyCodeCurrency,
      SupplierAccountGroup,
      ProductDescription,
      ProductType,
      ProductGroup,
      SupplierName,
      SupplierGST,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      AmountInTransactionCurrency,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      TaxBaseAmountInTransCrcy,
      //      ReferenceDocumentFiscalYear,
      //      ReferenceDocument,
      //      ReferenceDocumentItem,
      IncotermsClassification,
      IncotermsLocation1,
      PurchasingGroup,
      PurchasingOrganization,
      PurchaseRequisition,
      CreationDate,
      PurchaseRequisitionItem,
      YY1_DepartmentNamePR_PRI,
      CreatedByUser,
      MaterialTypeName,
      BusinessPlace,
      ProductGroupName,
      ProductGroupText,
      SGST_RATE,
      CGST_RATE,
      IGST_RATE,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      CGST_AMT,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      SGST_AMT,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      IGST_AMT,
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      TotalTax,
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      TotalAmount,
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      FreightAmount,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      TDSAMOUNT,
      @Aggregation.default: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      RoundOff,
      TaxCodeName,
      DocumentReferenceID,
      Region,
      Supplier
}
