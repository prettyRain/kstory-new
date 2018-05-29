package com.ningpai.util;

/**
 * 接口方法名
 */
public class MethodConstants {
    /**
     * 云ERP基础信息API (Base)
     */
    //店铺查询
    public static String GETSHOP = "gy.erp.shop.get";
    //仓库查询
    public static String GETWAREHOUSE = "gy.erp.warehouse.get";
    //供应商查询
    public static String GETSUPPLIER = "gy.erp.supplier.get";
    //支付方式查询
    public static String GETTRADEPAYMENT = "gy.erp.trade.payment.get";
    //省市区信息查询
    public static String GETAREA = "gy.erp.area.get";
    //平台账务流水账查询
    public static String GETALIPAYACCOUNTORDER = "gy.erp.alipay.account.order.get";
    //平台费用科目查询
    public static String GETTENANTPLATFORMSUBJECT = "gy.erp.tenant.platform.subject.get";
    //系统费用科目查询
    public static String GETSYSSUBJECT = "gy.erp.syssubject.get";
    //系统费用科目新增
    public static String ADDTENANTSYSSUBJECT = "gy.erp.tenant.sys.subject.add";
    /**
     * 云ERP商品API (Product)
     */
    //商品单位查询
    public static String GETITEMSUNIT = "gy.erp.items.unit.get";
    //查询商品
    public static String GETITEMS = "gy.erp.items.get";
    //新增商品
    public static String ADDITEM = "gy.erp.item.add";
    //修改商品
    public static String UPDATEITEM = "gy.erp.item.update";
    //删除商品
    public static String DELETEITEM = "gy.erp.item.delete";
    //新增商品规格
    public static String ADDITEMSKU = "gy.erp.item.sku.add";
    //修改商品规格
    public static String UPDATEITEMSKU = "gy.erp.item.sku.update";
    //删除商品规格
    public static String DELETEITEMSKU = "gy.erp.item.sku.delete";
    //商品条码查询
    public static String GETITEMBARCODE = "gy.erp.item.barcode.get";
    //商品条码新增
    public static String ADDITEMBARCODE = "gy.erp.item.barcode.add";
    /**
     * 云ERP订单API (Trade)
     */
    //订单新增
    public static String ADDTRADE = "gy.erp.trade.add";
    //订单查询
    public static String GETTRADE = "gy.erp.trade.get";
    //订单备注修改
    public static String UPDATETRADEMEMO = "gy.erp.trade.memo.update";
    //订单标记修改
    public static String UPDATETRADETAG = "gy.erp.trade.tag.update";
    //订单退款状态修改
    public static String UPDATETRADEREFUND = "gy.erp.trade.refund.update";
    //发货单查询
    public static String GETTRADEDELIVERYS = "gy.erp.trade.deliverys.get";
    //历史发货单查询
    public static String GETTRADEDELIVERYSHISTORY = "gy.erp.trade.deliverys.history.get";
    //发货单信息修改
    public static String UPDATETRADEDELIVERYS = "gy.erp.trade.deliverys.update";
    //退换货单查询
    public static String GETTRADERETURN = "gy.erp.trade.return.get";
    //退换货单新增
    public static String ADDTRADERETURN = "gy.erp.trade.return.add";
    //退货单入库
    public static String APPROVETRADERETURN = "gy.erp.trade.return.approve";
    //历史订单查询
    public static String GETTRADEHISTORY = "gy.erp.trade.history.get";
    //退款单新增
    public static String ADDTRADEREFUND = "gy.erp.trade.refund.add";
    //退款单查询
    public static String GETTRADEREFUND = "gy.erp.trade.refund.get";
    /**
     * 云ERP库存API (Stock)
     */
    //调拨单查询
    public static String GETSTOCKTRANSFER = "gy.erp.stock.transfer.get";
    //调拨单新增
    public static String ADDSTOCKTRANSFER = "gy.erp.stock.transfer.add";
    //调拨单出库
    public static String OUTSTOCKTRANSFER = "gy.erp.stock.transfer.out";
    //调拨单出库
    public static String INSTOCKTRANSFER = "gy.erp.stock.transfer.in";
    //调整单据查询
    public static String GETSTOCKADJUSTHEADER = "gy.erp.stock.adjustheader.get";
    //调整单明细查询
    public static String GETSTOCKADJUSTDETAIL = "gy.erp.stock.adjustdetail.get";
    //调整单新增
    public static String ADDSTOCKADJUST = "gy.erp.stock.adjust.add";
    //盘点单查询
    public static String GETSTOCKCOUNT = "gy.erp.stock.count.get";
    //盘点单据查询
    public static String GETSTOCKCOUNTORDER = "gy.erp.stock.count.order.get";
    //盘点单盈亏明细查询
    public static String GETSTOCKCOUNTORDERBREAKEVEN = "gy.erp.stock.count.order.breakeven.get";
    //盘点单新增
    public static String ADDSTOCKCOUNT = "gy.erp.stock.count.add";
    //盘点单修改
    public static String UPDATESTOCKCOUNT = "gy.erp.stock.count.update";
    //库存查询(新)
    public static String GETSTOCKNEW = "gy.erp.new.stock.get";
    //销货收款单查询
    public static String GETCUSTOMERPAYMENT = "gy.erp.customerpayment.get";
    //进销存数据查询
    public static String GETREPORTITEMSTOCKCRM = "gy.erp.report.itemstockcrm.get";
    //供应商流水账查询
    public static String GETSTOCKSUPPLIERBILL = "gy.erp.stock.supplierbill.get";
    /**
     * 云ERP采购API (Purchase)
     */
    //采购订单查询
    public static String GETPURCHASE = "gy.erp.purchase.get";
    //采购订单新增
    public static String ADDPURCHASE = "gy.erp.purchase.add";
    //采购订单审核
    public static String APPROVEPURCHASE = "gy.erp.purchase.approve";
    //采购入库单查询
    public static String GETPURCHASEARRIVE = "gy.erp.purchase.arrive.get";
    //采购入库单新增
    public static String ADDPURCHASEARRIVE = "gy.erp.purchase.arrive.add";
    //采购入库单新增(新)
    public static String ADDPURCHASEARRIVENEW = "gy.erp.new.purchase.arrive.add";
    //采购入库单修改
    public static String UPDATEPURCHASEARRIVE = "gy.erp.purchase.arrive.update";
    //采购入库单审核
    public static String APPROVEPURCHASEARRIVENEW = "gy.erp.new.purchase.arrive.approve";
    //采购退货单查询
    public static String GETPURCHASERETURN = "gy.erp.purchase.return.get";
    //采购退货单新增
    public static String ADDPURCHASERETURN = "gy.erp.purchase.return.add";
    //采购退货单出库
    public static String PURCHASERETURNOUT = "gy.erp.purchase.return.out";
    //采购预付款单查询
    public static String GETPURCHASEPREPAY = "gy.erp.purchase.prepay.get";
    //采购应收应付单查询
    public static String GETPURCHASEPAYMENT = "gy.erp.purchase.payment.get";
    /**
     * 云ERP会员信息API (Member)
     */
    //会员查询
    public static String GETVIP = "gy.erp.vip.get";
    //会员新增
    public static String ADDVIP = "gy.erp.vip.add";
    //会员修改
    public static String UPDATEVIP = "gy.erp.vip.update";
    //收付款账户查询
    public static String GETACCOUNTINFO = "gy.erp.account.info.get";

}
