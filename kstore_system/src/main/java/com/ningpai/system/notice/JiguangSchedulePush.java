package com.ningpai.system.notice;

import cn.jiguang.common.TimeUnit;
import cn.jiguang.common.Week;
import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jpush.api.JPushClient;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.schedule.ScheduleListResult;
import cn.jpush.api.schedule.ScheduleResult;
import cn.jpush.api.schedule.model.SchedulePayload;
import cn.jpush.api.schedule.model.TriggerPayload;
import com.ningpai.system.notice.bean.Notice;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 定时消息推送
 * Created by dll on 2018/1/31.
 *
 */
public class JiguangSchedulePush {

    protected static final Logger LOG = LoggerFactory.getLogger(JiguangSchedulePush.class);

    public static void main(String[] args) {

//        deleteSchedule("bff64b7e-0662-11e8-9219-f8fa2df9c302");Succeed to get response OK - responseCode:200
        findScheduleList();
    }

    /**
     * 创建定时推送
     * @param notice 消息通知
     * @return
     */
    public static ScheduleResult pushSchedule(Notice notice) {
        JPushClient jpushClient = new JPushClient(JiguangPush.masterSecret, JiguangPush.appKey);
        String name = "test_schedule_example";
        PushPayload push = JiguangPush.buildPushObject_android_ios_alias_alert(notice);
        try {
            ScheduleResult result = jpushClient.createSingleSchedule(name, notice.getTime(), push);
            LOG.info("schedule result is " + result);
            return result;
        } catch (APIConnectionException e) {
            LOG.error("Connection error. Should retry later. ", e);
        } catch (APIRequestException e) {
            LOG.error("Error response from JPush server. Should review and fix it. ", e);
            LOG.info("HTTP Status: " + e.getStatus());
            LOG.info("Error Code: " + e.getErrorCode());
            LOG.info("Error Message: " + e.getErrorMessage());
        }
        return null;
    }

    /**
     * 删除定时推送
     * @param scheduleId
     */
    public static void deleteSchedule(String scheduleId) {
        JPushClient jpushClient = new JPushClient(JiguangPush.masterSecret, JiguangPush.appKey);
        try {
            jpushClient.deleteSchedule(scheduleId);
        } catch (APIConnectionException e) {
            LOG.error("Connection error. Should retry later. ", e);
        } catch (APIRequestException e) {
            LOG.error("Error response from JPush server. Should review and fix it. ", e);
            LOG.info("HTTP Status: " + e.getStatus());
            LOG.info("Error Code: " + e.getErrorCode());
            LOG.info("Error Message: " + e.getErrorMessage());
        }
    }

    /**
     * 获取定时推送列表
     */
    public static void findScheduleList() {
        int page = 1;
        JPushClient jpushClient = new JPushClient(JiguangPush.masterSecret, JiguangPush.appKey);

        try {
            ScheduleListResult list = jpushClient.getScheduleList(page);
            LOG.info("total " + list.getTotal_count());
            for(ScheduleResult s : list.getSchedules()) {
                LOG.info(s.toString());
            }
        } catch (APIConnectionException e) {
            LOG.error("Connection error. Should retry later. ", e);
        } catch (APIRequestException e) {
            LOG.error("Error response from JPush server. Should review and fix it. ", e);
            LOG.info("HTTP Status: " + e.getStatus());
            LOG.info("Error Code: " + e.getErrorCode());
            LOG.info("Error Message: " + e.getErrorMessage());
        }
    }

    /**
     * 根据定时推送ID修改通知内容
     * @param scheduleId
     */
    public static void updateSchedule(String scheduleId) {
        JPushClient jpushClient = new JPushClient(JiguangPush.masterSecret, JiguangPush.appKey);
        String[] points = {Week.MON.name(), Week.FRI.name()};
        TriggerPayload trigger = TriggerPayload.newBuilder()
                .setPeriodTime("2015-08-01 12:10:00", "2015-08-30 12:12:12", "15:00:00")
                .setTimeFrequency(TimeUnit.WEEK, 2, points)
                .buildPeriodical();
        SchedulePayload payload = SchedulePayload.newBuilder()
                .setName("test_update_schedule")
                .setEnabled(false)
                .setTrigger(trigger)
                .build();
        try {
            jpushClient.updateSchedule(scheduleId, payload);
        } catch (APIConnectionException e) {
            LOG.error("Connection error. Should retry later. ", e);
        } catch (APIRequestException e) {
            LOG.error("Error response from JPush server. Should review and fix it. ", e);
            LOG.info("HTTP Status: " + e.getStatus());
            LOG.info("Error Code: " + e.getErrorCode());
            LOG.info("Error Message: " + e.getErrorMessage());
        }
    }

    /**
     * 根据定时推送ID获取通知内容
     * @param scheduleId
     */
    public static void getSchedule(String scheduleId) {
        JPushClient jpushClient = new JPushClient(JiguangPush.masterSecret, JiguangPush.appKey);

        try {
            ScheduleResult result = jpushClient.getSchedule(scheduleId);
            LOG.info("schedule " + result);
        } catch (APIConnectionException e) {
            LOG.error("Connection error. Should retry later. ", e);
        } catch (APIRequestException e) {
            LOG.error("Error response from JPush server. Should review and fix it. ", e);
            LOG.info("HTTP Status: " + e.getStatus());
            LOG.info("Error Code: " + e.getErrorCode());
            LOG.info("Error Message: " + e.getErrorMessage());
        }
    }
}
