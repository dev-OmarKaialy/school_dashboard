enum Demo { test1, test2 }

enum Roles { super_admin, manager, admin, worker, driver }

enum CouponType { percent, fixed }

enum DiscountType { category, subCategory, product }

enum OrderType { takeAway, restaurant, delivery }

enum OrderStatus { pending, accepted, in_progress, assigned_to_delivery, finished, rejected, canceled }

enum PaymentWay { cash, visa, zain }

enum CouponDiscount { discountPercent, discountamount }

enum ProductVarietyType { LARGE, MEDIUM, SMALL }

enum IdType { ID, passport }

enum NotificationRelation { product, category, subCategory, offer, none }

enum PermissionsEnum {
  //sub_ category
  view_sub_category,
  create_sub_category,
  update_sub_category,
  delete_sub_category,
  // product
  view_product,
  create_product,
  update_product,
  delete_product,
// orders
  view_order,
  delete_order,
  accept_order,
  reject_order,
  in_progress_order,
  assigned_to_delivery_order,
  finish_order,
// adtiion
  view_addition,
  create_addition,
  update_addition,
  delete_addition,
// branch
  view_branch,
  create_branch,
  update_branch,
  delete_branch,
// coupon
  view_coupon,
  create_coupon,
  update_coupon,
  delete_coupon,
// expense
  view_expense,
  create_expense,
  update_expense,
  delete_expense,
// offers
  view_offer,
  create_offer,
  update_offer,
  delete_offer,
// floor
  view_floor,
  create_floor,
  update_floor,
  delete_floor,
// floor
  view_table,
  create_table,
  update_table,
  delete_table,
}

class EnumValues<T> {
  Map<String, T> map;
  EnumValues(this.map);
  Map<T, String> get reverse => map.map((k, v) => MapEntry(v, k));
}
