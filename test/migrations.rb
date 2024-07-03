# frozen_string_literal: true

class RemoveNameFromUsersByRemoveColumn < ActiveRecord::Migration::Current
  def change
    safer_remove_column :users, :name
  end
end

class RemoveNameFromProductsByRemoveColumn < ActiveRecord::Migration::Current
  def change
    safer_remove_column :products, :name, :string
  end
end

class RemoveNameFromUsersByRemoveColumns < ActiveRecord::Migration::Current
  def change
    safer_remove_columns :users, :name
  end
end

class RemoveNameFromProductsByRemoveColumns < ActiveRecord::Migration::Current
  def change
    safer_remove_columns :products, :name, type: :string
  end
end

class RenameNameInUsers < ActiveRecord::Migration::Current
  def change
    safer_rename_column :users, :name, :new_name
  end
end

class RenameNameInProducts < ActiveRecord::Migration::Current
  def change
    safer_rename_column :products, :name, :new_name
  end
end

class RemoveNameFromUsersByChangeTableRemove < ActiveRecord::Migration::Current
  def change
    change_table :users do |t|
      t.string :email
      t.safer_remove(:name)
    end
  end
end

class RemoveNameFromProductsByChangeTableRemove < ActiveRecord::Migration::Current
  def change
    change_table :products do |t|
      t.safer_remove :name, type: :string
    end
  end
end
