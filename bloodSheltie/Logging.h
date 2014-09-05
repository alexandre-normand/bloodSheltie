#import <CocoaLumberjack/CocoaLumberjack.h>

#define BLOOD_SHELTIE_LOG_CONTEXT 1046

#define BLOODSLogError(frmt, ...)    LOG_OBJC_MAYBE(LOG_ASYNC_ERROR,   LOG_LEVEL_DEF, LOG_FLAG_ERROR,  \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define BLOODSLogWarn(frmt, ...)     LOG_OBJC_MAYBE(LOG_ASYNC_WARN,    LOG_LEVEL_DEF, LOG_FLAG_WARN,   \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define BLOODSLogInfo(frmt, ...)     LOG_OBJC_MAYBE(LOG_ASYNC_INFO,    LOG_LEVEL_DEF, LOG_FLAG_INFO,    \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define BLOODSLogVerbose(frmt, ...)  LOG_OBJC_MAYBE(LOG_ASYNC_VERBOSE, LOG_LEVEL_DEF, LOG_FLAG_VERBOSE, \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define BLOODSLogTrace()             LOG_OBJC_MAYBE(LOG_ASYNC_TRACE,   LOG_LEVEL_DEF, LOG_FLAG_TRACE, \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, @"%@[%p]: %@", THIS_FILE, self, THIS_METHOD)

#define BLOODSLogTrace2(frmt, ...)   LOG_OBJC_MAYBE(LOG_ASYNC_TRACE,   LOG_LEVEL_DEF, LOG_FLAG_TRACE, \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, frmt, ##__VA_ARGS__)


#define BLOODSLogCError(frmt, ...)      LOG_C_MAYBE(LOG_ASYNC_ERROR,   LOG_LEVEL_DEF, LOG_FLAG_ERROR,   \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define BLOODSLogCWarn(frmt, ...)       LOG_C_MAYBE(LOG_ASYNC_WARN,    LOG_LEVEL_DEF, LOG_FLAG_WARN,    \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define BLOODSLogCInfo(frmt, ...)       LOG_C_MAYBE(LOG_ASYNC_INFO,    LOG_LEVEL_DEF, LOG_FLAG_INFO,    \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define BLOODSLogCVerbose(frmt, ...)    LOG_C_MAYBE(LOG_ASYNC_VERBOSE, LOG_LEVEL_DEF, LOG_FLAG_VERBOSE, \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define BLOODSLogCTrace()               LOG_C_MAYBE(LOG_ASYNC_TRACE,   LOG_LEVEL_DEF, LOG_FLAG_TRACE, \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, @"%@[%p]: %@", THIS_FILE, self, __FUNCTION__)

#define BLOODSLogCTrace2(frmt, ...)     LOG_C_MAYBE(LOG_ASYNC_TRACE,   LOG_LEVEL_DEF, LOG_FLAG_TRACE, \
                                                  BLOOD_SHELTIE_LOG_CONTEXT, frmt, ##__VA_ARGS__)