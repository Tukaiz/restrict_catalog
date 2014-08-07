require "restrict_catalog/version"

module RestrictCatalog
  class RestrictCatalogFeatureDefinition
    include FeatureSystem::Provides
    def permissions
      [
        {
          can: true,
          callback_name: 'can_manage_catalog_claims',
          name: 'Can Manage Catalog Groups'
        }
      ]
    end
  end

  module Authorization
    module Permissions

      def restrict_catalogs_and_products
        UserEditContext.call(@user, @site)
        accessible_root_ids = @user.full_claims.map(&:catalog_ids).flatten
        accessible_root_catalogs = Catalog.find(accessible_root_ids)
        accessible_catalog_ids = accessible_root_catalogs.map(&:subtree_ids).flatten

        accessible_product_ids = Catalog.includes(:products).find(
          accessible_catalog_ids
        ).map{ |c| c.product_ids }.flatten

        accessible_catalog_ids += accessible_root_catalogs.map(&:ancestor_ids).flatten

        can :read, Catalog, active: true, id: accessible_catalog_ids
        can :view, Catalog, active: true, id: accessible_catalog_ids
        can :read, Product, archived: false, id: accessible_product_ids
        can :view, Product, archived: false, id: accessible_product_ids
      end

      def can_manage_catalog_claims
        can :manage, CatalogClaim
      end
    end
  end
end

require 'restrict_catalog/railtie' if defined?(Rails)
