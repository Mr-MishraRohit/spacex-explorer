import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacex_explorer/app/utils/utils.dart';
import 'package:spacex_explorer/app/widgets/ContentText.dart';
import '../../../strings/string_constant.dart';
import '../controllers/launch_controller.dart';

class LaunchFilterBar extends StatelessWidget {
  final LaunchController controller;

  const LaunchFilterBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContentText(
          color: Colors.black87,
          text: StringConstant.filterLaunches,
          textSize: 8.w,
          fontWeight: FontWeight.w600,
        ),

        SizedBox(height: 3.h),

        // Year Dropdown
        DropdownButtonFormField<String>(
          hint: ContentText(
            color: Colors.black87,
            text: StringConstant.selectYear,
            textSize: 5.w,
            fontWeight: FontWeight.w600,
          ),
          value: controller.selectedYear.value,
          items: List.generate(20, (i) {
            final year = (2024 - i).toString();
            return DropdownMenuItem(value: year, child: Text(year));
          }),
          onChanged: (val) {
            controller.selectedYear.value = val;
          },
        ),
        const SizedBox(height: 8),

        // Success Dropdown
        DropdownButtonFormField<bool>(
          // hint: const Text("Success Status"),
          hint: ContentText(
            color: Colors.black87,
            text: StringConstant.successStatus,
            textSize: 5.w,
            fontWeight: FontWeight.w600,
          ),
          value: controller.selectedSuccess.value,
          items: [
            DropdownMenuItem(
              value: true,
              child: ContentText(
                color: Colors.black87,
                text: StringConstant.success,
                textSize: 5.0.w,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownMenuItem(
              value: false,
              child: ContentText(
                color: Colors.black87,
                text: StringConstant.failed,
                textSize: 5.0.w,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          onChanged: (val) {
            controller.selectedSuccess.value = val;
          },
        ),
        const SizedBox(height: 8),

        // Rocket name input (could be dropdown or text)
        TextFormField(
          decoration: const InputDecoration(
            labelText: StringConstant.rocketType,
          ),
          onChanged: (val) {
            controller.selectedRocket.value = val.trim();
          },
        ),

        SizedBox(height: 3.h),

        ElevatedButton(
          onPressed: () {
            Get.back(); // Close sheet
            controller.fetchFilterLaunches(
              year: controller.selectedYear.value,
              rocketName: controller.selectedRocket.value,
              success: controller.selectedSuccess.value.toString(),
              refresh: true,
            ); // Refresh data
          },
          child: ContentText(
            color: Colors.black87,
            text: StringConstant.applyFilters,
            textSize: 5.0.w,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
