#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Joe's Blog"
    xml.author "Joe"
    xml.description "Ramble Chat"
    xml.link "http://localhost:3000"
    xml.language "en"

    for article in @articles
      xml.item do
        xml.title article.title
        xml.author "Joe"
        xml.pubDate article.created_at
        xml.link "http://localhost:3000/articles/" + article.id.to_s
        xml.guid article.id
        text = article.body
      end
    end
  end
end
