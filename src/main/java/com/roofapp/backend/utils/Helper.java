package com.roofapp.backend.utils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Helper {

    private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public static Double aroundDouble(Double val) {
        if (val != null)
            return new BigDecimal(val.toString()).setScale(2, RoundingMode.HALF_UP).doubleValue();
        return 0D;
    }

    public static Integer aroundToTheWhole(Double val) {
        if (val != null)
            return new BigDecimal(val.toString()).setScale(0, RoundingMode.HALF_UP).intValue();
        return 0;
    }


    public static String dateFormat(Date date) {
        return df.format(date);
    }

}
