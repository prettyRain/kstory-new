<!DOCTYPE html>
<html>
<head>

    <title>会员中心 - 运费说明</title>
 <#assign basePath=request.contextPath>
<#assign backUrl="${basePath}/intoPage.htm?pageName=member/about" />
 <#include '/common/head.ftl' />
    <style>
        .vheader{padding: 0px!important;}

        .views{

            font-size: 0.25rem;
            color: #333;
            /*margin-top:0.2rem ;*/
            overflow: scroll;
        }
        .views h4{
             line-height: 0.7rem;
             text-indent: 0.3rem;
            font-size: 12px;
            color: #030303;
            letter-spacing: 1.01px;

        }
        .views p{

            opacity: 0.65;
            font-size: 12px;
            color: #030303;
            letter-spacing: 1px;
            line-height: 20px;



        }
        .views p{
            margin: 0rem 0.2rem 0.2rem 0.3rem;
        }
        .views h3{
            line-height: 0.6rem;
            text-align: center;
        }
        .views div{
            width: 100%;
            height: 100px;
        }
        .views p:first-of-type{
            margin-bottom: 0;
        }
        .views p:nth-child(7){
            margin-bottom: 0;
        }
        ::-webkit-scrollbar{width:3px;}
        ::-webkit-scrollbar-track{background-color:#ffffff;}
        ::-webkit-scrollbar-thumb{background-color:#c7c7cc;}
      /*  ::-webkit-scrollbar-thumb:hover {background-color:#cccccc}
        ::-webkit-scrollbar-thumb:active {background-color:#c7c7cc}*/
    </style>
</head>
<body>
<#--<#assign vtitle="运费说明" />
<#assign backUrl="${basePath}/intoPage.htm?pageName=member/about" />-->
<#--<#include "/common/head_back.ftl"/>-->
<div class="views">
    <h4>零售商品：</h4>
    <p>1.在“中国960官方商城”购买零售商品，配送到社区店，不收取任何费用。</p>
    <h4>批发商品、批发+零售商品：</h4>
    <p>1.订单中商品金额＜399元，收基础运费10元，重量超出30kg的，超出重量按1元/kg加收续重运费；</p>
    <p>2.订单中商品金额≥399元，免基础运费，重量超出30kg的，超出重量按1元/kg加收续重运费；</p>
    <p>3.订单中商品金额≥599元，免基础运费，重量超出50kg的，超出重量按1元/kg加收续重运费；</p>
    <p>4.订单中商品金额≥999元，免基础运费，重量超出100kg的，超出重量按1元/kg加收续重运费。</p>
    <h4>特别说明：</h4>
    <p>1.由于部分商品的重量可能存在误差，故针对所有计重收费订单，系统会自动扣减重量10%后计算运费<strong>（例：结算页订单金额400元，商品总重量显示38kg，系统扣减重量10%后按34.2kg计算运费）</strong>如用户对扣减后的重量仍有异议，请及时联系客服沟通核实，经核实确认因商品重量误差导致用户多支付运费的，多支付运费将退还给用户。   </p>
    <p>2.商品重量计算为商品实际重量乘以90%，向上取整数位，超出0.01kg按1kg收取运费。<strong>（例：订单商品超出重量4.2kg，向上取整数至5kg，按1元/kg收续重运费5元）</strong></p>
    <p>3.商品金额为购物车页面显示的数额，须减去促销活动的金额。</p>
    <p>4.商品重量以毛重计算（含商品销售包装的重量）。</p>
    <p>5.当订单拆分成多个订单配送时，按支付页面的运费标准收费，不额外收取多次配送费用。</p>
    <p>6.运费的收取标准据实进行相应调整，具体以商品详情页及结算页公示的运费为准。</p>

    <div></div>

</div>
</body>
</html>