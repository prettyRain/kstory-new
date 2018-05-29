package com.ningpai.goods.bean;

/**
 * 商品认证
 * Created by Administrator on 2017/3/17.
 */
public class GoodsAuth {
    private Long id;
    private String authName;//认证说明
    private String authsrc;//认证图片

    public GoodsAuth() {
    }

    public GoodsAuth(Long id, String authName, String authsrc) {
        this.id = id;
        this.authName = authName;
        this.authsrc = authsrc;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAuthName() {
        return authName;
    }

    public void setAuthName(String authName) {
        this.authName = authName;
    }

    public String getAuthsrc() {
        return authsrc;
    }

    public void setAuthsrc(String authsrc) {
        this.authsrc = authsrc;
    }
}
