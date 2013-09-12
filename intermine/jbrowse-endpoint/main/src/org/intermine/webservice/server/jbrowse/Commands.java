package org.intermine.webservice.server.jbrowse;

import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class Commands {

    public enum Action {STATS, REFERENCE, FEATURES};

    // return null if not a suitable command.
    // Interprets commands such as: /7227/features/X?start=100&end=200&type=Gene
    // See: http://gmod.org/wiki/JBrowse_Configuration_Guide#Writing_JBrowse-compatible_Web_Services
    public static Command getCommand(
            String pathInfo,
            Map<String, String> parameters) {
        if (pathInfo == null) return null;

        Integer start = getIntegerParam(parameters, "start");
        Integer end = getIntegerParam(parameters, "end");

        String[] parts = StringUtils.split(pathInfo.substring(1), "/");
        if (parts.length < 3 || parts.length > 4 ) return null;

        String domain = parts[0];
        String actionName = parts[1];
        String section = parts[2];
        String realSection = (parts.length == 4) ? parts[3] : null;
        Segment segment;
        
        if ("global".equals(section)) {
            segment = Segment.GLOBAL_SEGMENT;
        } else {
            segment = new Segment(("stats".equals(actionName) && "region".equals(section) ? realSection : section), start, end);
        }
        String featureType = parameters.get("type");
        Action action = null;

        if ("stats".equals(actionName)) {
            action = Action.STATS;
        } else if ("features".equals(actionName)) {
            if ("true".equals(parameters.get("reference"))){
                action = Action.REFERENCE;
            } else {
                action = Action.FEATURES; 
            } 
        }
        if (action == null) {
            return null;
        } else {
            return new Command(action, domain, featureType, segment);
        }
    }

    private static Integer getIntegerParam(Map<String, String> params, String key) {
        String numStr = params.get(key);
        if (numStr == null || "null".equalsIgnoreCase(numStr)) {
            return null;
        }
        return Integer.valueOf(numStr);
    }

    private static <K, V> V getOrElse(Map<K, V> mapping,
            K key, V ifMissing) {
        V value = mapping.get(key);
        if (value == null) {
            return ifMissing;
        } else {
            return value;
        }
    }

}
