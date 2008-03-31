require File.dirname(__FILE__) + '/../test_helper'

class RssFeedTest < ActiveSupport::TestCase
  def setup
    @sample_rss = <<RSS
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
    <channel>
        <title>Snow-Wolf.net Recent Entries</title>
        <link>http://snow-wolf.net/</link>
        <description>We Are Tumblin'!</description>
        <language>en-us</language>
        <lastBuildDate>Mon, 31 Mar 2008 02:30:36 -0000</lastBuildDate>
        <item>
            <title>All Your (Code) Base Are Belong To GitHub</title>
            <link>http://snow-wolf.net/entry/2008/3/all-your-code-base-are-belong-github/</link>
            <description>Yay for a worn-out meme and a bigger hurrah for an awesome service! &amp;lt;a href=&amp;quot;http://github.com/&amp;quot; title=&amp;quot;GitHub&amp;quot;&amp;gt;GitHub&amp;lt;/a&amp;gt; is a hosting solution for the &amp;lt;a href=&amp;quot;http://git.or.cz/&amp;quot; title=&amp;quot;Git - Distributed Version Control&amp;quot;&amp;gt;Git&amp;lt;/a&amp;gt; version control system.

Why Git? Git provides a different model for version control from traditional centralized version control systems.  Git uses a distributed model where every checkout is actually a complete repository.  This means you have complete history along with all branches.  Others can clone out of your checkout. And merging, something that traditionally very painful in systems like Subversion, is easy and pain-free.  Not mention Git being extremely fast, space efficient and able to be used even while offline.

GitHub takes all the power and provides a great interface, easy code sharing and the ability to easily fork other projects hosted on GitHub.  Built by &amp;lt;a href=&amp;quot;http://ozmm.org/&amp;quot; title=&amp;quot;Chris Wanstrath&amp;quot;&amp;gt;Chris Wanstrath&amp;lt;/a&amp;gt;, &amp;lt;a href=&amp;quot;http://rubyisawesome.com/&amp;quot; title=&amp;quot;Tom Preston-Werner&amp;quot;&amp;gt;Tom Preston-Werner&amp;lt;/a&amp;gt; and (apparently) &amp;lt;a href=&amp;quot;http://www.pjhyett.com/&amp;quot; title=&amp;quot;PJ Hyett&amp;quot;&amp;gt;PJ Hyett&amp;lt;/a&amp;gt;, the app is already solid for a beta and there&amp;#39;s going to be quite a few more goodies added before launch.  Others have already noted the interesting social aspects so I won&amp;#39;t dog on that point too much.

GitHub comes highly recommended and I still have two invites available if anyone&amp;#39;s interested.</description>
            <dc:creator xmlns:dc="http://purl.org/dc/elements/1.1/">Daniel</dc:creator>
            <guid>http://snow-wolf.net/entry/2008/3/all-your-code-base-are-belong-github/</guid>
        </item>
        <item>
            <title>HTML Elements Quiz</title>
            <link>http://snow-wolf.net/entry/2008/3/html-elements-quiz/</link>
            <description>&amp;lt;a href=&amp;quot;http://www.justsayhi.com/bb/html_quiz&amp;quot; title=&amp;quot;HTML Quiz&amp;quot;&amp;gt;How Many HTML Elements Can You Name In 5 Minutes?&amp;lt;/a&amp;gt; - Got a 53 out of 91 one handed (&amp;lt;strong&amp;gt;Number Two&amp;lt;/strong&amp;gt; was in the other arm).</description>
            <dc:creator xmlns:dc="http://purl.org/dc/elements/1.1/">Daniel</dc:creator>
            <guid>http://snow-wolf.net/entry/2008/3/html-elements-quiz/</guid>
        </item>
    </channel>
</rss>    
RSS
    @sample_atom = <<ATOM
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" xml:lang="en-us">
    <title>Snow-Wolf.net Recent Entries</title>
    <link href="http://snow-wolf.net/" rel="alternate"/>
    <link href="http://snow-wolf.net/feeds/atom/" rel="self"/>
    <id>http://snow-wolf.net/</id>
    <updated>2008-03-29T17:17:16Z</updated>
    <entry>
        <title>All Your (Code) Base Are Belong To GitHub</title>
        <link href="http://snow-wolf.net/entry/2008/3/all-your-code-base-are-belong-github/" rel="alternate"/>
        <author>
            <name>Daniel</name>
        </author>
        <id>http://snow-wolf.net/entry/2008/3/all-your-code-base-are-belong-github/</id>
        <summary type="html">Yay for a worn-out meme and a bigger hurrah for an awesome service! &amp;lt;a href=&amp;quot;http://github.com/&amp;quot; title=&amp;quot;GitHub&amp;quot;&amp;gt;GitHub&amp;lt;/a&amp;gt; is a hosting solution for the &amp;lt;a href=&amp;quot;http://git.or.cz/&amp;quot; title=&amp;quot;Git - Distributed Version Control&amp;quot;&amp;gt;Git&amp;lt;/a&amp;gt; version control system.

Why Git? Git provides a different model for version control from traditional centralized version control systems.  Git uses a distributed model where every checkout is actually a complete repository.  This means you have complete history along with all branches.  Others can clone out of your checkout. And merging, something that traditionally very painful in systems like Subversion, is easy and pain-free.  Not mention Git being extremely fast, space efficient and able to be used even while offline.

GitHub takes all the power and provides a great interface, easy code sharing and the ability to easily fork other projects hosted on GitHub.  Built by &amp;lt;a href=&amp;quot;http://ozmm.org/&amp;quot; title=&amp;quot;Chris Wanstrath&amp;quot;&amp;gt;Chris Wanstrath&amp;lt;/a&amp;gt;, &amp;lt;a href=&amp;quot;http://rubyisawesome.com/&amp;quot; title=&amp;quot;Tom Preston-Werner&amp;quot;&amp;gt;Tom Preston-Werner&amp;lt;/a&amp;gt; and (apparently) &amp;lt;a href=&amp;quot;http://www.pjhyett.com/&amp;quot; title=&amp;quot;PJ Hyett&amp;quot;&amp;gt;PJ Hyett&amp;lt;/a&amp;gt;, the app is already solid for a beta and there&amp;#39;s going to be quite a few more goodies added before launch.  Others have already noted the interesting social aspects so I won&amp;#39;t dog on that point too much.

GitHub comes highly recommended and I still have two invites available if anyone&amp;#39;s interested.</summary>
    </entry>
    <entry>
        <title>HTML Elements Quiz</title>
        <link href="http://snow-wolf.net/entry/2008/3/html-elements-quiz/" rel="alternate"/>
        <author>
            <name>Daniel</name>
        </author>
        <id>http://snow-wolf.net/entry/2008/3/html-elements-quiz/</id>
        <summary type="html">&amp;lt;a href=&amp;quot;http://www.justsayhi.com/bb/html_quiz&amp;quot; title=&amp;quot;HTML Quiz&amp;quot;&amp;gt;How Many HTML Elements Can You Name In 5 Minutes?&amp;lt;/a&amp;gt; - Got a 53 out of 91 one handed (&amp;lt;strong&amp;gt;Number Two&amp;lt;/strong&amp;gt; was in the other arm).</summary>
    </entry>
</feed>
ATOM
    
    @rf = RssFeed.create(:title => 'Test Feed', :url => 'http://www.snow-wolf.net/')
    @rss_feed_doc = Hpricot.XML(@sample_rss)
    @atom_feed_doc = Hpricot.XML(@sample_atom)
  end
  
  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_process_rss_feed
    assert_nothing_raised(RuntimeError) { @rf.process_rss_feed(@rss_feed_doc) }
    
    rf = RssFeed.find(:first)
    assert_equal(2, rf.rss_articles.size)
    assert_equal('All Your (Code) Base Are Belong To GitHub', rf.rss_articles[0].title)
    assert_equal('HTML Elements Quiz', rf.rss_articles[1].title)
  end
  
  def test_process_atom_feed
    assert_nothing_raised(RuntimeError) { @rf.process_atom_feed(@atom_feed_doc) }
    
    rf = RssFeed.find(:first)
    assert_equal(2, rf.rss_articles.size)
    assert_equal('All Your (Code) Base Are Belong To GitHub', rf.rss_articles[0].title)
    assert_equal('HTML Elements Quiz', rf.rss_articles[1].title)
  end
  
  def test_process_feed
    assert_nothing_raised(RuntimeError) { @rf.process_feed(@sample_rss) }
    assert_equal('rss', @rf.process_feed(@sample_rss))
    
    assert_nothing_raised(RuntimeError) { @rf.process_feed(@sample_atom) }
    assert_equal('atom', @rf.process_feed(@sample_atom))
    
    assert_raise(RuntimeError) { @rf.process_feed('<?xml version="1.0"?><foo><bar>Hello world.</bar></moof></foo>') }
  end
end
