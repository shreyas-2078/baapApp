import '../../models/product_response_model/product_response_model.dart';

class Calculations {
  static double getPriceWithTotalTax({required ProductList? item}) {
    double? tax = 0;
    double? regularTaxWithTax = 0;
    int gst = item?.gst ?? 0;
    int igst = item?.igst ?? 0;
    double cgst = item?.cgst ?? 0;
    double sgst = item?.sgst ?? 0;

    tax = gst + igst + cgst + sgst;
    double totalTax = (item?.regularPrice ?? 0) * tax;
    double divideTax = totalTax / 100;
    regularTaxWithTax = (item?.regularPrice ?? 0) + divideTax;

    return regularTaxWithTax;
  }

  static double getPriceWithMarketPrice({required ProductList? item}) {
    double? tax = 0;
    double? regularTaxWithTax = 0;
    int gst = item?.gst ?? 0;
    int igst = item?.igst ?? 0;
    double cgst = item?.cgst ?? 0;
    double sgst = item?.sgst ?? 0;

    tax = gst + igst + cgst + sgst;
    double totalTax = (item?.marketPrice ?? 0) * tax;
    double divideTax = totalTax / 100;
    regularTaxWithTax = (item?.marketPrice ?? 0) + divideTax;
    return regularTaxWithTax;
  }

  static double getTotalTax({required ProductList? item}) {
    double? tax = 0;

    int gst = item?.gst ?? 0;
    int igst = item?.igst ?? 0;
    double cgst = item?.cgst ?? 0;
    double sgst = item?.sgst ?? 0;

    tax = gst + igst + cgst + sgst;
    return tax;
  }
}
