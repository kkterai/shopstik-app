module Slugifiable

  module InstanceMethods

    def slug
      if !!self.username
        self.username.gsub(" ", "-").downcase
      end
    end

  end

  module ClassMethods

    def find_by_slug(slug)
      self.all.find { |object| object.slug == slug}
    end

  end
end
