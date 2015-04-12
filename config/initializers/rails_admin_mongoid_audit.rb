RailsAdmin::Extensions::MongoidAudit::VersionProxy.class_eval do
  def message
    @message = @version.action
    if table == 'User'
      prefix_string = ''
      # prefix_string = 'User created ' if @message == 'create'
      # prefix_string = 'User deleted ' if @message == 'destroy'
      if @message == 'create'
        return 'User created'
      end
      if @message == 'destroy'
        return 'User deleted'
      end
      if @version.modified.has_key?("sign_in_count")
        prefix_string = 'User signed in'
        if @version.modified.has_key?("current_sign_in_at")
          prefix_string += ' again: ' + @version.modified[:current_sign_in_at].to_s
          if @version.modified.has_key?("last_sign_in_at")
            prefix_string += ' (Last sign in was at: ' + @version.modified[:last_sign_in_at].to_s + ")"
          end
        end
        if @version.modified.has_key?("current_sign_in_ip")
          prefix_string += ' from a new ip: ' + @version.modified[:current_sign_in_ip]
          if @version.modified.has_key?("last_sign_in_ip")
            prefix_string += ' (Last sign in was from: ' + @version.modified[:last_sign_in_ip] + ")"
          end
        end
      end
      return prefix_string
    else
      if @message == 'create'
        return 'new'
      end
      if @message == 'destroy'
        return 'delete'
      end
      mods = @version.modified.to_a.map do |c|
        if c[1].class.name == "Moped::BSON::Binary" || c[1].class.name == "BSON::Binary"
          c[0] + " = {binary data}"
        elsif c[1].to_s.length > 220
          c[0] + " = " + c[1].to_s[0..200]
        else
          c[0] + " = " + c[1].to_s
        end

      end
      @version.respond_to?(:modified) ? @message + ' ' + table +  " [" + mods.join(", ") + "]" : @message
    end
  end
end