# frozen_string_literal: true

class RemoveNameFromUsersBySaferRemoveColumn < ActiveRecord::Migration::Current
  def change
    safer_remove_column :users, :name
  end
end

class RemoveNameFromProductsBySaferRemoveColumn < ActiveRecord::Migration::Current
  def change
    safer_remove_column :products, :name, :string
  end
end

class RemoveNameFromUsersBySaferRemoveColumns < ActiveRecord::Migration::Current
  def change
    safer_remove_columns :users, :name
  end
end

class RemoveNameFromProductsBySaferRemoveColumns < ActiveRecord::Migration::Current
  def change
    safer_remove_columns :products, :name, type: :string
  end
end

class SaferRenameNameInUsers < ActiveRecord::Migration::Current
  def change
    safer_rename_column :users, :name, :new_name
  end
end

class SaferRenameNameInProducts < ActiveRecord::Migration::Current
  def change
    safer_rename_column :products, :name, :new_name
  end
end

class SaferRemoveNameFromUsersByChangeTableRemove < ActiveRecord::Migration::Current
  def change
    change_table :users do |t|
      t.safer_remove :name
    end
  end
end

class SaferRemoveNameFromProductsByChangeTableRemove < ActiveRecord::Migration::Current
  def change
    change_table :products do |t|
      t.safer_remove :name, type: :string
    end
  end
end

class SaferRenameNameFromUsersByChangeTable < ActiveRecord::Migration::Current
  def change
    change_table :users do |t|
      t.safer_rename :name, :new_name
    end
  end
end

class SaferRenameNameFromProductsByChangeTable < ActiveRecord::Migration::Current
  def change
    change_table :products do |t|
      t.integer :price
      t.safer_rename :name, :new_name
    end
  end
end

class RemoveNameFromUsersByRemoveColumn < ActiveRecord::Migration::Current
  def change
    remove_column :users, :name, :string
  end
end

class RemoveNameFromUsersByRemoveColumns < ActiveRecord::Migration::Current
  def change
    remove_columns :users, :name, type: :string
  end
end

class RenameNameInUsers < ActiveRecord::Migration::Current
  def change
    rename_column :users, :name, :new_name
  end
end

class RemoveNameFromUsersByChangeTableRemove < ActiveRecord::Migration::Current
  def change
    change_table :users do |t|
      t.remove :name, type: :string
    end
  end
end

class RenameNameFromUsersByChangeTable < ActiveRecord::Migration::Current
  def change
    change_table :users do |t|
      t.rename :name, :new_name
    end
  end
end