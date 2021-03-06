class DesktopnotificationListener < AsakusaSatellite::Hook::Listener
  def read_js(filename)
    js_path = Rails.root.join 'plugins/as_desktopnotification/app/assets/javascripts'
    File.read(js_path.join filename)
  end

  render_on  :account_setting_item, :partial => "desktopnotification_setting"

  def global_footer(context)
    controller = context[:request][:controller]
    action     = context[:request][:action]

    case {:controller => controller, :action => action}
    when {:controller => "account", :action => "index"}
      "<script>#{read_js 'desktopnotification_setting.js'}</script>"
    when {:controller => "chat",    :action => "room"}
      "<script>#{read_js 'desktopnotification_notify.js'}</script>"
    end
  end

  private
  def render(context, options)
    context[:controller].send(:render_to_string, {:locals => context}.merge(options))
  end
end

