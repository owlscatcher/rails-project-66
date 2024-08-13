class AddHtmlUrlToRepository < ActiveRecord::Migration[7.1]
  def change
    add_column :repositories, :html_url, :string
  end
end
