def entries
  # This will generate at most 3 SQL select statements due to eager loading:
  #@blogs = Blog.includes(:author, :image)
  # What's happening under the covers:
  # Blog Load (0.1ms)  SELECT "blogs".* FROM "blogs"
  # Author Load (0.1ms)  SELECT "authors".* FROM "authors"  WHERE "authors"."id" IN (1, 2, 3, 4)
  # Image Load (0.1ms)  SELECT "images".* FROM "images"  WHERE "images"."blog_id" IN (1, 2, 3, 4)


  # And this will generate at most 1 SQL select statement using INNER JOINS:
  @blogs = Blog.select("title, images.image_file_path, authors.name")
               .joins(:author, :image)
               .map(&:attributes)
  # What's happening under the covers:
  # Blog Load (0.2ms)  SELECT title, images.image_file_path, authors.name FROM "blogs" INNER JOIN "authors" ON "authors"."id" = "blogs"."author_id" INNER JOIN "images" ON "images"."blog_id" = "blogs"."id"
  # Rendered blogs/entries.html.erb within layouts/application (0.1ms)
  # Completed 200 OK in 6ms (Views: 4.7ms | ActiveRecord: 0.2ms)
end