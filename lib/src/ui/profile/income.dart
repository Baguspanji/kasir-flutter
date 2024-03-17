import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/incomeController.dart';
import 'package:kasir_app/src/model/income_model.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:kasir_app/src/ui/components/modal.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IncomeUI extends StatefulWidget {
  static const String routeName = '/income';

  @override
  State<IncomeUI> createState() => _IncomeUIState();
}

class _IncomeUIState extends State<IncomeUI> {
  final conIncome = Get.put(IncomeController());

  DateTime dateFrom = DateTime.now();
  String selectType = 'Harian';

  final _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));

    conIncome.isLoading.value = true;
    conIncome.getTransaksi(1);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    conIncome.getTransaksi(conIncome.incomePage.value + 1);
    if (mounted) setState(() {});

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    conIncome.getTransaksi(1);

    conIncome.init();
    super.initState();
  }

  Future<void> _openModalForm() async {
    await Modals.showModal(
      title: 'Pilih Tanggal',
      subTitle: '',
      subTitleWidget: StatefulBuilder(
        builder: (context, setState) => formExport(context, setState),
      ),
    );
  }

  Widget formExport(BuildContext context, Function setState) {
    return Column(
      children: [
        SizedBox(height: height(context) * 0.01),
        Container(
          width: width(context) * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Tanggal',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                width: width(context),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: const EdgeInsets.only(bottom: 10, top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: dateFrom,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != DateTime.now())
                      setState(() {
                        dateFrom = picked;
                      });
                  },
                  child: Text(
                    dateFormatddMMMMyyyy(dateFrom),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height(context) * 0.01),
        Container(
          width: width(context) * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Tipe Laporan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                width: width(context),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(bottom: 10, top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectType = newValue!;
                      });
                    },
                    items: <String>[
                      'Harian',
                      'Bulanan',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height(context) * 0.01),
        Container(
          width: width(context) * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width(context),
                padding: const EdgeInsets.symmetric(vertical: 8),
                margin: const EdgeInsets.only(
                  bottom: 10,
                  top: 5,
                  right: 20,
                  left: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: primaryColor,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    conIncome.exportExcel(dateFrom, selectType);
                    Get.back();
                  },
                  child: Center(
                    child: Text(
                      'Export',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width(context),
              height: height(context),
              color: Colors.white,
            ),
            Container(
              width: width(context),
              height: height(context) * 0.11,
              decoration: BoxDecoration(
                gradient: bgGradient,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (() => Get.back()),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xCEFFFFFF),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: secondaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                      Text(
                        'Riwayat Pendapatan',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: _openModalForm,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xCEFFFFFF),
                          ),
                          child: Icon(
                            Icons.file_download_outlined,
                            color: secondaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: Obx(() {
                    final transaksi = conIncome.listIncome.value;

                    if (conIncome.isLoading.value) {
                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        children: [
                          for (var i = 0; i < 8; i++)
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: CustomShimmer(
                                width: width(context),
                                height: width(context) * 0.2,
                                radius: 10,
                              ),
                            )
                        ],
                      );
                    }

                    if (transaksi.isEmpty) {
                      return CustomEmptyData(
                        height: height(context) * 0.9,
                        text: 'Data tidak ditemukan',
                        onPressed: () async {
                          conIncome.isLoading.value = true;
                          conIncome.getTransaksi(1);
                        },
                      );
                    }

                    return AnimatedContainer(
                      height: height(context) * 0.82,
                      duration: const Duration(seconds: 1),
                      child: CustomRefresh(
                        controller: _refreshController,
                        onRefresh: () => _onRefresh(),
                        onLoading: () => _onLoading(),
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          children: [
                            ...transaksi
                                .map((e) => _itemProductList(context, e)),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemProductList(BuildContext context, IncomeModel item) {
    // intl date
    final date = DateFormat('dd MMMM yyyy')
        .format(DateTime.parse(item.transaction!.date ?? ''));

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  item.item!.name ?? '-',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '${item.quantity} - ${toRupiah(double.parse(item.price ?? "0"))} = ${toRupiah(double.parse(item.price ?? "0") * double.parse(item.quantity ?? "0"))}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
