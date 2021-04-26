module ApplicationHelper

    def gravatar_for(user, size = 80)
        email_address = user.email.downcase
        hash = Digest::MD5.hexdigest(email_address)
        image_src = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(image_src, alt: "#{user.username}`s profile picture", class: "rounded shadow mx-auto d-block")
    end

end
