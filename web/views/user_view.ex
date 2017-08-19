defmodule Emporium.UserView do
  use Emporium.Web, :view
  import Phoenix.HTML
  import Phoenix.HTML.Form
  import Phoenix.HTML.Link
  import Phoenix.HTML.Tag

  def role_switch_tag(form, role, user_roles, id) do
    content_tag(:div, class: "switch tiny") do
      [content_tag(:input, "", class: "switch-input", id: "user_role_#{role.id}", type: "checkbox", name: "user[role[#{role.id}]]", checked: Enum.member?(user_roles, role.id)),
      content_tag(:label, class: "switch-paddle", for: "user_role_#{role.id}") do
        [content_tag(:span, class: "show-for-sr") do
           {:safe, ["#{role.name}"]}
         end,
        content_tag(:span, class: "switch-active", "aria-hidden": "true") do
          content_tag(:i, "", class: "fi-check small")
        end,
        content_tag(:span, class: "switch-inactive", "aria-hidden": "true") do
          content_tag(:i, "", class: "fi-x small")
        end]
      end]
    end
  end

end
