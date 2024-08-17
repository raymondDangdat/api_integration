// To parse this JSON data, do
//
//     final dataPlanModel = dataPlanModelFromJson(jsonString);

import 'dart:convert';

DataPlanModel dataPlanModelFromJson(String str) =>
    DataPlanModel.fromJson(json.decode(str));

class DataPlanModel {
  List<Plan> mtnPlan;
  List<Plan> gloPlan;
  List<Plan> airtelPlan;
  List<Plan> the9MobilePlan;

  DataPlanModel({
    required this.mtnPlan,
    required this.gloPlan,
    required this.airtelPlan,
    required this.the9MobilePlan,
  });

  factory DataPlanModel.fromJson(Map<String, dynamic> json) => DataPlanModel(
        mtnPlan: List<Plan>.from(json["MTN_PLAN"].map((x) => Plan.fromJson(x))),
        gloPlan: List<Plan>.from(json["GLO_PLAN"].map((x) => Plan.fromJson(x))),
        airtelPlan:
            List<Plan>.from(json["AIRTEL_PLAN"].map((x) => Plan.fromJson(x))),
        the9MobilePlan:
            List<Plan>.from(json["9MOBILE_PLAN"].map((x) => Plan.fromJson(x))),
      );
}

class Plan {
  dynamic id;
  dynamic dataplanId;
  dynamic network;
  dynamic planType;
  dynamic planNetwork;
  dynamic monthValidate;
  dynamic plan;
  dynamic planAmount;

  Plan({
    required this.id,
    required this.dataplanId,
    required this.network,
    required this.planType,
    required this.planNetwork,
    required this.monthValidate,
    required this.plan,
    required this.planAmount,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        dataplanId: json["dataplan_id"],
        network: json["network"],
        planType: json["plan_type"],
        planNetwork: json["plan_network"],
        monthValidate: json["month_validate"],
        plan: json["plan"],
        planAmount: json["plan_amount"],
      );
}
