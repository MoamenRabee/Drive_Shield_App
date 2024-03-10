import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:app/business_logic/profile/cubit/profile_cubit.dart';
import 'package:app/functions/functions.dart';
import 'package:app/models/account_statement_model/account_statement_model.dart';
import 'package:app/models/invoice/invoice_model.dart';
import 'package:app/models/receipt/receipt_model.dart';
import 'package:app/theme/colors.dart';
import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

part 'exports_state.dart';

class ExportsCubit extends Cubit<ExportsState> {
  ExportsCubit() : super(ExportsInitial());

  static ExportsCubit get(BuildContext context) => BlocProvider.of(context);

  bool isExportingAccountStatement = false;
  bool isExportingPDF = false;
  Future<void> exportAccountStatement(
    List<AccountStatementModel> listAccountStatement,
    BuildContext context,
  ) async {
    isExportingAccountStatement = true;
    emit(ExportLoading());
    try {
      var myFont = pw.Font.ttf((await rootBundle.load("assets/fonts/NotoSansArabic-Bold.ttf")));

      final pdf = pw.Document();

      int maxmum = 30;
      int corrant = 0;
      int pagesCount = (listAccountStatement.length / maxmum).ceil();
      int corrantPage = 1;

      while (corrantPage <= pagesCount) {
        List<AccountStatementModel> data = listAccountStatement;

        data = listAccountStatement.sublist(corrantPage == 1 ? 0 : ((corrantPage - 1) * maxmum), corrantPage == pagesCount ? null : maxmum + 1);

        pdf.addPage(
          pw.Page(
            textDirection: pw.TextDirection.rtl,
            theme: pw.ThemeData.withFont(
              base: myFont,
            ),
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context contextt) {
              return pw.Column(
                children: [
                  pw.Table(
                    children: [
                      pw.TableRow(
                        verticalAlignment: pw.TableCellVerticalAlignment.middle,
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex('#000000'),
                          borderRadius: pw.BorderRadius.circular(10),
                        ),
                        children: [
                          pw.Text('الرصيد', textAlign: pw.TextAlign.center, style: pw.TextStyle(color: PdfColor.fromHex('#ffffff'), fontSize: 8)),
                          pw.Text('مدين', textAlign: pw.TextAlign.center, style: pw.TextStyle(color: PdfColor.fromHex('#ffffff'), fontSize: 8)),
                          pw.Text('دائن', textAlign: pw.TextAlign.center, style: pw.TextStyle(color: PdfColor.fromHex('#ffffff'), fontSize: 8)),
                          pw.Text('المرجع', textAlign: pw.TextAlign.center, style: pw.TextStyle(color: PdfColor.fromHex('#ffffff'), fontSize: 8)),
                          pw.Text('وصف العملية', textAlign: pw.TextAlign.center, style: pw.TextStyle(color: PdfColor.fromHex('#ffffff'), fontSize: 8)),
                          pw.Text('النوع', textAlign: pw.TextAlign.center, style: pw.TextStyle(color: PdfColor.fromHex('#ffffff'), fontSize: 8)),
                          pw.Text('التاريخ', textAlign: pw.TextAlign.center, style: pw.TextStyle(color: PdfColor.fromHex('#ffffff'), fontSize: 8)),
                        ],
                      ),
                      ...data.map((e) {
                        corrant = corrant + 1;
                        return pw.TableRow(
                          children: [
                            pw.Text(e.amount, textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 8)),
                            pw.Text('${ProfileCubit.get(context).userModel?.name}', textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 8)),
                            pw.Text(e.contact.name, textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 8)),
                            pw.Theme(
                              data: pw.ThemeData.base(),
                              child: pw.Text('${e.reference}', textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 8)),
                            ),
                            pw.Text('${e.description}', textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 8)),
                            pw.Theme(
                              data: pw.ThemeData.base(),
                              child: pw.Text(e.kind, textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 8)),
                            ),
                            pw.Text(e.date.toString(), textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 8)),
                          ],
                        );
                      }),
                    ],
                  ),
                ],
              );
            },
          ),
        );
        corrantPage = corrantPage + 1;
      }

      // ignore: use_build_context_synchronously
      await saveFile(
        context: context,
        pdf: pdf,
        // ignore: use_build_context_synchronously
        name: formatDate(context, DateTime.now()),
      );

      isExportingAccountStatement = false;
      emit(ExportSuccess());
    } catch (e) {
      isExportingAccountStatement = false;
      emit(ExportError());
      debugPrint('$e');
    }
  }

  Future<void> downloadRecipt(BuildContext context, ReceiptModel receiptModel) async {
    isExportingPDF = true;
    emit(ExportLoading());

    try {
      var myFont = pw.Font.ttf((await rootBundle.load("assets/fonts/NotoSansArabic-Bold.ttf")));

      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          // ignore: use_build_context_synchronously
          textDirection: pw.TextDirection.rtl,
          theme: pw.ThemeData.withFont(
            // ignore: use_build_context_synchronously
            base: myFont,
          ),
          pageFormat: PdfPageFormat.a4,
          build: (contextt) {
            return pw.Padding(
              padding: const pw.EdgeInsets.all(20),
              child: pw.SizedBox(
                width: double.infinity,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'Bond Details'.tr(),
                      style: pw.TextStyle(
                        fontSize: 23.0,
                        fontWeight: context.locale.languageCode == 'en' ? pw.FontWeight.bold : null,
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    _titleValueWidget2(context, 'From'.tr(), receiptModel.contact.name, isAr: true),
                    _titleValueWidget2(context, 'Account'.tr(), '${receiptModel.account?.nameAr}'),
                    _titleValueWidget2(context, 'Reference'.tr(), '${receiptModel.reference}'),
                    _titleValueWidget2(context, 'Description'.tr(), '${receiptModel.description}'),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                      child: pw.Column(
                        children: [
                          pw.SizedBox(height: 30),
                          _titleValueWidget2(context, 'Date'.tr(), '${receiptModel.date}'),
                          _titleValueWidget2(context, 'Amount'.tr(), '${receiptModel.amount} ${'SAR'.tr()}', isAr: context.locale.languageCode == 'ar'),
                          _titleValueWidget2(context, 'Type'.tr(), receiptModel.kind, isAr: context.locale.languageCode == 'ar'),
                          _titleValueWidget2(context, 'Unallocated Amount'.tr(), '${receiptModel.unAllocateAmount} ${'SAR'.tr()}', isAr: context.locale.languageCode == 'ar'),
                          pw.Divider(
                            thickness: 0.5,
                            height: 40,
                          ),
                          pw.Align(
                            alignment: pw.AlignmentDirectional.centerStart,
                            child: pw.Text(
                              'Bond Assignments'.tr(),
                              style: pw.TextStyle(
                                fontSize: 20.0,
                                fontWeight: context.locale.languageCode == 'en' ? pw.FontWeight.bold : null,
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          _titleValueWidget2(context, 'Date'.tr(), '${receiptModel.date}'),
                          _titleValueWidget2(context, 'For'.tr(), 'فاتورة مبيعات', isAr: true),
                          _titleValueWidget2(context, 'Reference'.tr(), '${receiptModel.reference}'),
                          _titleValueWidget2(context, 'Amount'.tr(), '${receiptModel.amount} ${'SAR'.tr()}', isAr: context.locale.languageCode == 'ar'),
                          _titleValueWidget2(context, 'Options'.tr(), '${receiptModel.description}'),
                          pw.SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
      // ignore: use_build_context_synchronously
      await saveFile(
        context: context,
        pdf: pdf,
        // ignore: use_build_context_synchronously
        name: formatDate(context, DateTime.now()),
      );
      isExportingPDF = false;
      emit(ExportSuccess());
    } catch (e) {
      debugPrint('$e');
      isExportingPDF = false;
      emit(ExportError());
    }
  }

  Future<void> downloadInvoice(BuildContext context, InVoiceModel inVoiceModel) async {
    isExportingPDF = true;
    emit(ExportLoading());

    try {
      var myFont = pw.Font.ttf((await rootBundle.load("assets/fonts/NotoSansArabic-Bold.ttf")));

      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          // ignore: use_build_context_synchronously
          textDirection: pw.TextDirection.rtl,
          theme: pw.ThemeData.withFont(
            // ignore: use_build_context_synchronously
            base: myFont,
          ),
          pageFormat: PdfPageFormat.a4,
          build: (contextt) {
            return pw.Padding(
              padding: const pw.EdgeInsets.all(20),
              child: pw.SizedBox(
                width: double.infinity,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'Invoice Details'.tr(),
                      style: pw.TextStyle(
                        fontSize: 23.0,
                        fontWeight: context.locale.languageCode == 'en' ? pw.FontWeight.bold : null,
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Column(
                      children: [
                        _titleValueWidget2(context, 'Invoice Type'.tr(), '${inVoiceModel.type}'),
                        _titleValueWidget2(context, 'Status'.tr(), '${inVoiceModel.status}'),
                        _titleValueWidget2(context, 'Reference'.tr(), inVoiceModel.reference.toString()),
                        _titleValueWidget2(context, 'Release Date'.tr(), inVoiceModel.issueDate.toString()),
                        _titleValueWidget2(context, 'Expiry Date'.tr(), inVoiceModel.dueAmount.toString()),
                        _titleValueWidget2(context, 'Date of Supply'.tr(), inVoiceModel.issueDate.toString()),
                        _titleValueWidget2(context, 'From the Location'.tr(), '${inVoiceModel.owner?.shippingAddress.shippingCity}', isAr: context.locale.languageCode == 'ar'),
                        _titleValueWidget2(context, 'Payment Method'.tr(), '${inVoiceModel.paymentMethod}'),
                      ],
                    ),
                    pw.SizedBox(height: 30),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                      child: pw.Column(
                        children: [
                          pw.Align(
                            alignment: pw.AlignmentDirectional.centerStart,
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Customer'.tr(),
                                  style: pw.TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: context.locale.languageCode == 'en' ? pw.FontWeight.bold : null,
                                  ),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  "${inVoiceModel.contact?.name}",
                                  style: const pw.TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Divider(
                            thickness: 0.5,
                            height: 40,
                          ),
                          // ...List.generate(inVoiceModel.lineItems?.length ?? 0, (index) {
                          //   return pw.Column(
                          //     children: [
                          //       _titleValueWidget2(context, 'Product'.tr(), '${inVoiceModel.lineItems?[index].name}'),
                          //       _titleValueWidget2(context, 'Quantity'.tr(), '${inVoiceModel.lineItems?[index].quantity}'),
                          //       _titleValueWidget2(context, 'Unit Price'.tr(), '${inVoiceModel.lineItems?[index].unitPrice} ${'SAR'.tr()}'),
                          //       _titleValueWidget2(context, 'Discount'.tr(), '${inVoiceModel.lineItems?[index].discount} ${'SAR'.tr()}'),
                          //       _titleValueWidget2(context, 'Total Before Tax'.tr(), '${inVoiceModel.lineItems?[index].unitPrice}${'SAR'.tr()}'),
                          //       _titleValueWidget2(context, '${'Tax'.tr()} %', '${inVoiceModel.lineItems?[index].taxPercent}%'),
                          //       _titleValueWidget2(context, 'Tax Value'.tr(), '${double.parse(inVoiceModel.lineItems?[index].unitPrice ?? "0.0") * (double.parse(inVoiceModel.lineItems?[index].taxPercent ?? "0.0") / 100)} ${'SAR'.tr()}'),
                          //       _titleValueWidget2(context, 'Total'.tr(), '${double.parse(inVoiceModel.lineItems?[index].unitPrice ?? "0.0") + double.parse(inVoiceModel.lineItems?[index].unitPrice ?? "0.0") * (double.parse(inVoiceModel.lineItems?[index].taxPercent ?? "0.0") / 100)} ر.س'),
                          //       pw.Divider(
                          //         thickness: 0.5,
                          //         // color: MyColors.black,
                          //         height: 40,
                          //       ),
                          //     ],
                          //   );
                          // }),
                          _titleValueWidget2(context, '${'Total Before Tax'.tr()}:', '--	4,200.00 ${'SAR'.tr()}', isAr: context.locale.languageCode == 'ar'),
                          _titleValueWidget2(context, '${'Tax Value'.tr()}:', '--	630.00 ${'SAR'.tr()}', isAr: context.locale.languageCode == 'ar'),
                          _titleValueWidget2(context, '${'Total'.tr()}:', '	${inVoiceModel.total} ${'SAR'.tr()}', isAr: context.locale.languageCode == 'ar'),
                          _titleValueWidget2(context, '${'Deserved Amount'.tr()}:', '	${inVoiceModel.paidAmount} ${'SAR'.tr()}', isAr: context.locale.languageCode == 'ar'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
      // ignore: use_build_context_synchronously
      await saveFile(
        context: context,
        pdf: pdf,
        // ignore: use_build_context_synchronously
        name: formatDate(context, DateTime.now()),
      );
      isExportingPDF = false;
      emit(ExportSuccess());
    } catch (e) {
      debugPrint('$e');
      isExportingPDF = false;
      emit(ExportError());
    }
  }

  Future<void> saveFile({
    required BuildContext context,
    required String name,
    required pw.Document pdf,
  }) async {
    Permission permission = Permission.storage;
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final androidInfo = await deviceInfoPlugin.androidInfo;
      int sdkInt = androidInfo.version.sdkInt;

      if (sdkInt >= 33) {
        // ignore: use_build_context_synchronously
        // showMessage(context: context, message: 'الهاتف غير مدعوم لتنزيل الملفات يرجي التكلم مع المطور لحل المشكله', color: MyColors.redColor);
        permission = Permission.manageExternalStorage;
      }
    }

    final permissionStatus = await permission.status;

    if (permissionStatus.isDenied) {
      await permission.request();
      if (permissionStatus.isDenied) {
        await permission.request();
      }
    } else {
      final path = await getDownloadsDirectory();

      final file = File("${path?.path}/$name.pdf");
      await file.writeAsBytes(await pdf.save());
      await OpenFile.open(file.path);

      final fileToSave = File("/storage/emulated/0/Download/$name.pdf");
      await fileToSave.writeAsBytes(await pdf.save());
      // ignore: use_build_context_synchronously
      showMessage(context: context, message: 'تم الحفظ في ملف التحميلات');
    }
  }

  pw.Widget _titleValueWidget2(BuildContext context, String title, String value, {bool isAr = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 14.0,
            color: PdfColor.fromHex('#000000'),
            fontWeight: context.locale.languageCode == 'en' ? pw.FontWeight.bold : null,
            height: 2.43,
          ),
        ),
        pw.SizedBox(width: 10),
        pw.Expanded(
          child: pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 14.0,
              color: PdfColor.fromHex('#000000'),
              fontWeight: isAr == true ? null : pw.FontWeight.bold,
              height: 2.43,
            ),
            maxLines: 1,
            textAlign: pw.TextAlign.end,
          ),
        ),
      ],
    );
  }
}
