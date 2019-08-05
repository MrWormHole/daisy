module PublicHelper
  def calculate_rows_and_extras(posts_total_count,per_post_count_in_row)
    row_count = posts_total_count / per_post_count_in_row
    extra = posts_total_count % per_post_count_in_row
    return [row_count,extra]
  end
end
