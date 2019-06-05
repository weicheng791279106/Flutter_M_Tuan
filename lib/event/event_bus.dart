import 'package:event_bus/event_bus.dart';
import 'package:m_tuan_flutter/model/resp/login_resp.dart';

EventBus eventBus = new EventBus();

/**登录事件*/
class LoginEvent{
  User user;
  LoginEvent(this.user);
}

/**登出事件*/
class LogoutEvent{}