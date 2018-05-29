<#assign basePath=request.contextPath>
<style>
    .show-box{
        margin-bottom: 0!important;
    }
    .bgPop{
        top:249px;
    }
</style>
<div class="show-box">
    <div id="slides">

    <#if avc?? && (avc?size>0)>
        <#list avc as bigAdvert>
            <a class="slide" href="${bigAdvert.adverHref}" style="background-image:url(${bigAdvert.adverPath});"></a>
        </#list>
    </#if>

    </div>
</div>