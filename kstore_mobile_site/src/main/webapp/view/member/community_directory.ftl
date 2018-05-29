<!DOCTYPE html>
<html>
<head>

    <title>会员中心 - 社区店名录</title>
    <#assign basePath=request.contextPath>
        <#assign backUrl="${basePath}/intoPage.htm?pageName=member/about" />
        <#include '/common/head.ftl' />
        <style>
            /* .vheader{padding: 0px!important;}*/

            .views{

                font-size: 0.25rem;
                color: #333;
                /*margin-top:0.2rem ;*/
                overflow: scroll;
            }
            .views img{
                width: 100%;
            }
           /* .views h4{
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
            !*  ::-webkit-scrollbar-thumb:hover {background-color:#cccccc}
              ::-webkit-scrollbar-thumb:active {background-color:#c7c7cc}*!*/
        </style>
        </head>
<body>
<#assign vtitle="社区店名录" />
<#assign backUrl="${basePath}/intoPage.htm?pageName=member/about" />
<#include "/common/head_back.ftl"/>
<div class="views">
    <img src="${basePath}/images/community_directory.jpg">
</div>
</body>
</html>