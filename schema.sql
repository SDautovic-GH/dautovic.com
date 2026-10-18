-- Cloudflare D1 Schema for dautovic.com
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  excerpt TEXT,
  content TEXT NOT NULL,
  category TEXT DEFAULT 'General',
  tags TEXT DEFAULT '[]',
  read_time TEXT,
  status TEXT DEFAULT 'published',
  published_at TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_posts_slug ON posts(slug);
CREATE INDEX idx_posts_date ON posts(published_at DESC);
CREATE INDEX idx_posts_status ON posts(status);

-- Seed Historical Posts
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Finding Interesting Podcasts', 'finding-interesting-podcasts', 'Podcasts have become a great way to learn and keep up with the ongoings. Finding shows that interest you has been made easy by leading streaming services. This Google Search shows…', '<p>Podcasts have become a great way to learn and keep up with the ongoings. Finding shows that interest you has been made easy by leading streaming services. This <a href="https://www.google.com/search?q=popular+podcasts+feed+directory&amp;sca_esv=588018538&amp;ei=QCpvZfnRBf7W5NoP5IySyAU&amp;oq=popular+Podcasts+directory&amp;gs_lp=Egxnd3Mtd2l6LXNlcnAiGnBvcHVsYXIgUG9kY2FzdHMgZGlyZWN0b3J5KgIIADIIECEYoAEYwwQyCBAhGKABGMMESK5DUP4IWK00cAB4ApABAJgBoQGgAfoEqgEDNy4xuAEDyAEA-AEBwgIEEAAYR8ICBhAAGAcYHsICCxAAGIAEGIoFGIYDwgIKECEYoAEYwwQYCsICBBAhGAriAwQYACBBiAYBkAYI&amp;sclient=gws-wiz-serp">Google Search</a> shows a list of current leaders in streaming services.    </p>', 'Podcasts', '[]', '1 min read', 'published', '2023-12-05 09:13:50');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Finding Interesting RSS Feeds', 'rss-feeds-directory', 'Wondering what RSS feeds to follow on topics that interest you? This Google search is a good place to start. Feedly and Inoreader are very good online RSS feed readers. Both offer…', '<p>Wondering what RSS feeds to follow on topics that interest you? This <a href="https://www.google.com/search?q=popular+rss+feeds+directory&amp;sca_esv=588018538&amp;ei=uChvZbPACYbk5NoPiJe8yAI&amp;oq=best+rss+feeds+dire&amp;gs_lp=Egxnd3Mtd2l6LXNlcnAiE2Jlc3QgcnNzIGZlZWRzIGRpcmUqAggAMgYQABgWGB4yCxAAGIAEGIoFGIYDMgsQABiABBiKBRiGAzILEAAYgAQYigUYhgMyCxAAGIAEGIoFGIYDSMUbUPkKWNAQcAF4AZABAJgBTKAB0QKqAQE1uAEDyAEA-AEBwgIKEAAYRxjWBBiwA8ICChAAGIAEGIoFGEPCAgUQABiABOIDBBgAIEGIBgGQBgg&amp;sclient=gws-wiz-serp#ip=1">Google search</a> is a good place to start.</p>



<p><a href="https://feedly.com/">Feedly</a> and <a href="https://www.inoreader.com/">Inoreader </a>are very good online RSS feed readers. Both offer an option with free plan.</p>', 'RSS', '[]', '1 min read', 'published', '2023-12-05 08:14:45');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Doing good for humanity', 'doing-good-for-humanity', 'After ending his role at Microsoft in summer of 2008, Bill Gates will continue as world''s most powerful philanthropist. Time magazine writes this: Gates isn''t just focused on…', 'After ending his role at Microsoft in summer of 2008, Bill Gates will continue as world''s most powerful philanthropist. <a href="http://www.time.com">Time</a> magazine writes this:

<blockquote>Gates isn''t just focused on specific diseases and educational deficits. To him, that''s thinking small. Like the high school password stealer he once was, the cocky Harvard kid, Gates wants to rewrite the rules of the whole system. He''s all for capitalism — it has treated him well — but he gets that it''s not going to take care of everybody. The financial incentives to take care of the disadvantaged just aren''t there. So capitalism itself needs to be re-engineered. In his Harvard speech he introduces an idea he calls creative capitalism. </blockquote>

Read full article <a href="http://www.time.com/time/health/article/0,8599,1630188,00.html?xid=rss-topstories">Bill Gates goes back to school</a> and wish him best of luck, he is likely to need it.', 'Interesting', '[]', '1 min read', 'published', '2007-06-07 08:41:01');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Web 2.0 directory', 'web-20-directory', 'So where can you find all the Web 2.0 websites? Unless your daily read includes sites like TechCrunch , VentureBeat , 9rules , you may find it cumbersome to find the exciting new…', 'So where can you find all the Web 2.0 websites? Unless your daily read includes sites like <a href="http://www.techcrunch.com/">TechCrunch</a>, <a href="http://www.venturebeat.com/">VentureBeat</a>, <a href="http://9rules.com/">9rules</a>, you may find it cumbersome to find the exciting new web services.  

Solution is a Web 2.0 directory. The following two are pretty good:

<ul>
<li><a href="http://www.web2list.com/">Web2.0list</a> - typical directory with explanations</li> 
<li><a href="http://www.go2web20.net/">Go2Web20</a> - offers a catalog like view</li>
</ul>
Be forewarned, browsing through these could be a big time consumer.', 'Web 2.0', '["Web 2.0"]', '1 min read', 'published', '2007-01-19 10:40:44');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Web trends by Hitwise', 'top-25-websites-in-us', 'Hitwise tracks web trends for online marketing use, it is a great resource for web advertisers. Here are some interesting trends for this month: Top 25 websites in US Top industry…', '<a href="http://www.hitwise.com/">Hitwise</a> tracks web trends for online marketing use, it is a great resource for web advertisers. Here are some interesting trends for this month:
<ul>
	<li><a href="http://www.hitwise.com/datacenter/rankings.php">Top 25 websites in US</a></li>
	<li><a href="http://www.hitwise.com/datacenter/industrysearchterms/index.php">Top industry search terms</a></li>
</ul>
Interesting if you are curious, and useful if you advertise online.', 'Interesting', '["Web Services"]', '1 min read', 'published', '2007-01-17 09:30:42');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('How to get people to like you', 'how-to-get-people-to-like-you', 'Here are some very simple facts we forget (by Clipmarks ). Learn to remember names. A name is very important to someone. If you don’t take the time to learn someone’s name, it…', 'Here are some very simple facts we forget (by <a href="http://www.clipmarks.com/clipmark/A69D8C6D-051B-433A-8797-B99B61FB5A63/">Clipmarks</a>).

<ul>
	<li>
Learn to remember names. A name is very important to someone. If you don’t take the time to learn someone’s name, it indicates that you’re not interested in him or her. When someone remembers your name, it gives you the feeling that you are interesting or important.</li>

	<li>Be easy going and natural. When you are stiff, reserved or unresponsive, you unconsciously build up a barrier. But when you are easy going and natural it is easy for people to like you.</li>

	<li>Be interesting. Have something to talk about that people find interesting or stimulating. This way people want to be with you.</li>

	<li>Don’t have a big ego. If you give the impression that you know it all, that you are superior, you make it hard for people to like you. Be normally humble.</li>

	<li>Do some self-study and get rid of negative attitudes. People can consciously or unconsciously pick those up and they might find it irritable to be around you.</li>

	<li>Always look for the positive qualities in a person. Getting people to like you is merely the other side of liking them.</li>

	<li>Try to build up someone’s ego. Make compliments. Congratulate upon someone’s achievement, or express sympathy when they are in sorrow or if they feel disappointed. The ego is a sacred thing; every human being has the desire to feel important. When you deflate someone’s ego, you are wounding him deep inside.</li>

	<li>Give strength to people, support them. Help them to be stronger and they will give you affection.</li></ul>

Whether you like to admit it or not, we want people to like us. If someone tells you that he does not  really care if people like him or not, he simply is not being honest. The longing to be liked is one of our deepest desires. We want to be popular, we want people to speak nothing but good of us and we want to have affection of the people around us. It is in our human nature.

To find more go to: <a href="http://www.clipmarks.com/">Clipmarks</a>', 'Career Tips', '[]', '2 min read', 'published', '2007-01-11 13:15:44');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('What is Web 2.0', 'what-is-web-20', 'There are many different definitions circling around tech world. Most of explanations are long and include some form of Ajax , Web Services elements and minimal page refresh web…', 'There are many different definitions circling around tech world. Most of explanations are long and include some form of <a href="http://en.wikipedia.org/wiki/Ajax">Ajax</a>, <a href="http://en.wikipedia.org/wiki/Web_services">Web Services</a> elements and minimal page refresh web design characteristics. But the simplest definition yet, that I came across was given by <a href="http://www.informationweek.com/internet/showArticle.jhtml?articleID=193001026&amp;subSection=Web+Development">InformationWeek</a> magazine:

<blockquote>Web 2.0 is all the Web sites out there that get their value from the actions of users.</blockquote>

<a href="http://en.wikipedia.org/wiki/Main_Page">Wikipedia</a>, <a href="http://www.digg.com">Digg</a>, <a href="http://www.technorati.com">Technorati</a>, <a href="http://www.flickr.com">Filckr</a> are the perfect examples.', 'Web 2.0', '["Web 2.0", "Web Services"]', '1 min read', 'published', '2006-09-19 09:16:22');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Office 2007 delayed, AGAIN', 'office-2007-delayed-again', 'Oh it is just another slight delay they say, see this CNET story . And it has to do with some performance concerns discovered in latest test versions. Should not the development…', 'Oh it is just another slight delay they say, see this <a href="http://news.com.com/2100-1012_3-6089694.html">CNET story</a>. And it has to do with some performance concerns discovered in latest test versions. Should not the development be past that phase by now? The new target release date is "early 2007". Well we should see it by May I think.

And what about Windows Vista? 

It would be really nice to have joint launch of two most dominant software products after such a long pose. But who knows when they both can be ready. Perhaps mid 2007 if we are going to get a solid OS in Windows Vista. 

Can <a href="http://www.microsoft.com/">Microsoft</a> wait that long?', 'Microsoft', '["Office 2007", "Windows Vista"]', '1 min read', 'published', '2006-06-29 21:28:38');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Who do employers want', 'who-do-employers-want', 'Employers want to see the following qualities in prospective candidates: Drive - self motivation - willing to jump through the hoops on their own power, without having to be…', 'Employers want to see the following qualities in prospective candidates:
	<ul>
<li>Drive - self motivation - willing to jump through the hoops on their own power, without having to be asked, to achieve whatever goal is in front of them. Candidates should show something that they have done, not been part of or been involved in, either in a job or outside of a job.</li>
	<li>Curiosity - loving what they do - always curious about their job, field, profession. They read about it, study it, talk to other people about it, do it continuously. They work hard to stay current in it, not because they have to, but because they love to.</li>
	<li>Ethics - unethical person is not desired by any employer. Be honest, if you do not know an answer, say so. Discursive discussion on interview indicates that you are likely to do it if hired.</li>
	<li>Dedication - be willing to go above and beyond. Employers want someone whom they can count on, someone who truly cares about their job. </li></ul>

Candidates behavior during an interview matters as much as the skills they bring.
<ul>
	<li>If candidates never laugh - they are probably hard to get along with. </li>
	<li>If they constantly interrupt - they are egomaniacs, not welcome. </li>
	<li>If their facts are not straight - they are manipulating.</li></ul>
Reference calls are important. A good hiring manager will be on lookout for the following statements:
<ul>
	<li>Sometimes wasn''t that motivated - a candidate is a slow starter.</li>
	<li>Could sometimes be a little hard to get along with - is unpleasant.</li>
	<li>Had an easier time working with men than women - is a sexist.</li>
	<li>Was sometimes a little moody - likely suffering from a depression.</li></ul>

Most people downplay deficiencies in people they''ve worked with, so make sure references are good and given heads up. <a href="http://www.careerjournal.com/">CareerJournal</a> is an excellent resource for all aspects of job search process.', 'Career Tips', '[]', '2 min read', 'published', '2006-06-08 14:51:21');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Network neutrality matters', 'network-neutrality-matters', 'Not only would it go against the very nature of internet as we know it but it would also be a complete unfairness to all those who do not have resources to pay for better position…', 'Not only would it go against the very nature of internet as we know it but it would also be a complete unfairness to all those who do not have resources to pay for better position on major network carrier''s lines. They should be equally open to all. Just like our streets and our highways. Creating internet "Fast Lane" for those who pay more will degrade internet experience to all those who are not members of this elite group but still pay for their internet access. 

It is safe to say that internet is what it is today thanks to neutrality to all users. If this preferential treatment is allowed to form, it probably will never go away once instituted. Small business will suffer, it will be loss to everyone as innovation will be suppressed.

Organizations such as <a href="http://www.savetheinternet.com/=principles">Save the Internet</a> are starting to make their voices heard, but they have a very tough task on their hand going against powerful lobby.

<a href="http://en.wikipedia.org/wiki/Tim_Berners-Lee">Tim Berners-Lee</a>, considered by many to be the father of the web, says this about the issue:

<blockquote>When, seventeen years ago, I designed the Web, I did not have to ask anyone''s permission. The new application rolled out over the existing Internet without modifying it. I tried then, and many people still work very hard still, to make the Web technology, in turn, a universal, neutral, platform. It must not discriminate against particular hardware, software, underlying network, language, culture, disability, or against particular types of data. The Internet is increasingly becoming the dominant medium binding us. The neutral communications medium is essential to our society. It is the basis of a fair competitive market economy.</blockquote>

Where is the common sense?', 'Internet', '["Network Neutrality"]', '1 min read', 'published', '2006-05-03 12:09:23');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('IT Certifications devalue', 'it-certifications-devalue', 'Point blank, being certified must count for something. Logic would certainly support the theory that a knowledge verification process confirms ones qualifications. But then there…', 'Point blank, being certified must count for something. Logic would certainly support the theory that a knowledge verification process confirms ones qualifications. 

But then there is a real world out there that looks and feels very different from book knowledge tested for certification. 

Not testing for real hands-on work experience, something certified individuals will be doing, unless they plan to become instructors (if they do the lack of having done it in realty is not going to enable them to be good real life situation teachers), sort of falls short from being the highlight of ones resume. 

Besides that, certification vendors are in it for the money, so their interest in accommodating the industry must be questioned.

eWEEK has a good article on this topic <a href="http://www.eweek.com/article2/0,1895,1956636,00.asp?kc=ewnws050306dtx1k0000599">here</a>.', 'Career Tips', '[]', '1 min read', 'published', '2006-05-03 11:32:22');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Skype improves with new version', 'skype-improves-again', 'This is a good news for all Skype service users. Getting things done easier is what most care about and Skype has done great deal improving usability of it''s client. It was not…', 'This is a good news for all Skype service users. Getting things done easier is what most care about and Skype has done great deal improving usability of it''s client. It was not bad right out of the gate. They clearly understood what it should not be and built their client around simplicity foremost.

Then there is the price factor. There are other <a href="http://en.wikipedia.org/wiki/VoIP#Networks:_Software_Service">VOIP network software services</a> competing with Skype that are comparable. However most of them are focusing on affordability and leaving usability on second place of their priorities. 

Skype has made the right choice and their user base supports it. 

The newest improvements to Skype client are:
<ul>

	<li>Easy Dialing - instead of having to remember specific country codes, easily call landlines or cell phones worldwide by selecting the country of choice from a drop-down menu.</li>

	<li>Payments in Skype - payment is now built into the Skype software, making it simpler to buy Skype credit, SkypeOut minutes, ringtones from artists like Madonna and more.</li>

	<li>Send Short Message Service (SMS) Messages - send a one-way SMS message to any mobile phone number in the world by selecting a SkypeOut contact, entering a mobile phone number or selecting a Skype contacts - mobile phone number in their profile.</li>

	<li>View Outlook Contacts - quickly view Outlook contacts in Skype and call directly using SkypeOut, a call from Skype to traditional landlines or cell phones.</li>

	<li>Improved Conference Calling - instantly see who is talking on a conference call as the participants - picture flashes when they begin to speak.</li>

	<li>Shared Contact Groups - easily share contacts with friends and family and help them connect with other people; bring groups together with just one click of a button to start a group chat or conference call.</li>

	<li>Simplified Registration - create Skype accounts in one simple step.</li>

	<li>Automatic Updates - receive an automatic prompt to download the latest Skype software any time the product is upgraded.</li>

	<li>Call Quality Management - lets users adjust and manage their computer environment and internet connection to ensure they have the best possible call quality.</li></ul>', 'Phone', '["Skype"]', '2 min read', 'published', '2006-05-03 10:42:03');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Why have a blog?', 'why-have-a-blog', 'It used to be just a cool thing to have, but that was long time ago. Boston Globe makes great validation argument for blogging: Blogging is good for your career. A well-executed…', 'It used to be just a cool thing to have, but that was long time ago. <a href="http://www.boston.com/news/globe/?p1=Header_YourConnection">Boston Globe</a> makes great validation argument for blogging:

<blockquote> Blogging is good for your career. A well-executed blog sets you apart as an expert in your field.</blockquote>

Read full article <a href="http://www.boston.com/business/globe/articles/2006/04/16/blogs_essential_to_a_good_career/?p1=MEWell_Pos3">here</a>.', 'Blogging', '[]', '1 min read', 'published', '2006-04-18 08:57:52');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Google Calendar released', 'google-calendar-released', 'Google Calendar is live and it looks pretty good, detaild tour can be viewed here . The Key features: Text recognition - In adding an event, or detecting a new event from Gmail,…', '<a href="http://www.google.com/calendar">Google Calendar</a> is live and it looks pretty good, detaild tour can be viewed <a href="http://www.google.com/googlecalendar/tour.html">here</a>.

The Key features:

<ul>

	<li>Text recognition</em> - In adding an event, or detecting a new event from Gmail, Calendar automatically detects event-specific words and suggests the adding of a new event with data that is auto-structured.</li>

	<li>Manage Multiple Calendars</em> - set up multiple calendars (work, personal, etc) and view them separately or together.</li>

	<li>Heavy Gmail integration</em> - Gmail recognizes when messages include event information, allowing quick add to Google Calendar with just a couple clicks. Google Calendar link is on the right side of the Gmail page.</li>

	<li>Sharing</em> - Calendars can be shared with others, users can subscribe to others'' shared calendars. Read/write permissions can be granted on a per user basis. Calendars can be published via a web page or via RSS, so readers do not need to be on the Google Calendar platform.</li>

	<li>Importing</em> - import events from other calendar programs, including Yahoo Calendar and Microsoft Outlook. Click on Settings, then Import Calendar.</li>

	<li>Calendar Search</em>  - Of course.</li>
</ul>', 'Google', '["Email", "Google Calendar"]', '1 min read', 'published', '2006-04-13 06:36:02');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Social engineering malware', 'social-engineering-malware', 'One of the biggest security risks for internet users, especially home users, is socially engineered malware designed to trick unsuspecting users into an action that triggers…', 'One of the biggest security risks for internet users, especially home users, is socially engineered malware designed to trick unsuspecting users into an action that triggers unwanted malware installation. The only defense is prevention but it can only be fully accomplished by proper user education. 

Starting with simple free tools can be the first step. Suspicious and information fishing sites can be easily identified by browser plug-ins such as <a href="http://www.siteadvisor.com/">SiteAdvisor</a> (I wrote about it <a href="http://www.dautovic.com/?p=126/">here</a>) available for IE and Firefox.

First infection may not be system killer but often is the culprit that brings <a href="http://en.wikipedia.org/wiki/Spyware">spyware</a>, <a href="http://en.wikipedia.org/wiki/Virus_%28computing%29">viruses</a> and <a href="http://en.wikipedia.org/wiki/Rootkits">rootkits</a>.
Microsoft has admitted that this is a huge problem and often the only full recovery path is to completely rebuild the system. <a href="http://www.eweek.com/">eWeek</a> has great <a href="http://www.eweek.com/article2/0,1895,1945808,00.asp">article</a> in which Mike Danseglio, program manager in the Security Solutions group at Microsoft says:

<blockquote>When you are dealing with rootkits and some advanced spyware programs, the only solution is to rebuild from scratch. In some cases, there really is no way to recover without nuking the systems from orbit.</blockquote>', 'Security', '["Rootkits", "Spyware", "Viruses"]', '1 min read', 'published', '2006-04-05 19:29:00');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Apple backs Windows on MAC', 'apple-backs-windows-on-mac', 'Apple not so surprisingly, released today beta software package named Boot Camp that enables Windows XP installation on Intel-based MAC computers. It is significant step in…', '<a href="http://www.apple.com/">Apple</a> not so surprisingly, <a href="http://www.apple.com/pr/library/2006/apr/05bootcamp.html">released</a> today beta software package named <a href="http://www.apple.com/macosx/bootcamp/">Boot Camp</a> that enables Windows XP installation on Intel-based MAC computers. It is significant step in Apple''s struggle to gain <a href="http://www.forbes.com/markets/2005/05/23/0523automarketscan04.html?partner=yahootix&amp;referrer=">maket share</a> which has seen better days in 1990''s.

This move will not get it done, but may be enough to convince some to try Mac in dual boot environment with Windows giving Apple at least hardware sales boost. 

Philip Schiller, Apple''s senior vice president of Worldwide Product Marketing says:

<blockquote>Apple has no desire or plan to sell or support Windows, but many customers have expressed their interest to run Windows on Apple''s superior hardware now that we use Intel processors. We think Boot Camp makes the Mac even more appealing to Windows users considering making the switch.</blockquote>

For now Mac is more secure OS, but that could change if it becomes more popular. It will be interesting to see how consumers react.', 'Microsoft', '[]', '1 min read', 'published', '2006-04-05 18:33:25');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('ajaxWrite web based word processor', 'ajaxwrite-web-based-word-processor', 'ajaxWrite is a free web based word processor launched by well known, disruptive entrepreneur Michael Robertson . It is designed to provide free word processing application that…', '<a href="http://www.ajaxwrite.com/">ajaxWrite</a> is a free web based word processor launched by well known, disruptive entrepreneur <a href="http://www.michaelrobertson.com/index.php">Michael Robertson</a>. It is designed to provide free word processing application that will work on all operating systems via web browser. For now, it only works with <a href="http://www.mozilla.com/firefox/">Firefox 1.5</a>.

Notable benefits/advantages are:

<ul>
	<li>Global access, all you need is an internet connection</li>

	<li>Platform independent, you can use it with any operating system</li>

	<li>Automatic updates and upgrades</li>

	<li>Server side management - all the busywork is done for you</li>
</ul>

Documents can be saved as: MS Word (.doc), RTF, Text and PDF. It is not ready to replace MS Word yet but it could some day. Michael Robertson states:

<blockquote>My plan is to replace bloated, expensive PC software with a system that dynamically loads software to your computer when you need it and at no cost. Want to write a document? One click and you''ll have a word processor at your fingertips. Need to create a financial model? Click, and a spreadsheet program is at your service. The software will always be up to date and run on any Mac/Win/Lin computer. </blockquote>

<a href="http://www.ajaxlaunch.com/">ajaxLaunch</a> promises to launch a new application on every Wednesday at 12 PST. Let''s see what comes next.', 'Web Services', '[]', '1 min read', 'published', '2006-03-23 09:30:33');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('MIT''s $100 Linux laptop vs. Origami', 'mits-100-linux-laptop-vs-origami', 'Why would anyone mock a laptop that costs $100 and is primarily for distribution to those who can not afford anything better? MIT is developing a bare bone, mobile computer that…', 'Why would anyone mock a laptop that costs $100 and is primarily for distribution to those who can not afford anything better?

<a href="http://web.mit.edu">MIT</a> is developing a bare bone, mobile computer that will be distributed through UN programs to people in developing countries. It will lack many features found on a typical personal computer, such as a hard disk and software and will run on Linux OS.

Microsoft may not like it (<a href="http://news.yahoo.com/s/nm/20060316/tc_nm/microsoft_gates_dc">Bill Gates</a> on MIT''s $100 PC) for just that reason, but they also may not like it because of their own <a href="http://www.origami.com/">Origami</a> device. 
There is no doubt that Origami will be far better, but it will also be 5-9 times more expansive. There is hardly going to be any competition here, those who will use $100 computers can not afford Origami device anyway. What is really bugging MS may just be the fact that Linux is going to spread faster then Windows in developing countries.', 'Open Source', '["MIT", "Open Source", "Origami"]', '1 min read', 'published', '2006-03-16 12:59:09');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Google Calendar details emerge', 'google-calendar-more-details', 'Google is on the path of releasing Calendar service that will be integrated with Gmail services. Release date is unknown at this time but interesting details are emerging and I am…', 'Google is on the path of releasing Calendar service that will be integrated with Gmail services. Release date is unknown at this time but interesting details are emerging and I am sure we will hear more about it before it is released. It looks appealing already.

More <a href="http://www.techcrunch.com/2006/03/08/exclusive-screenshots-google-calendar/">here</a> with screenshots.', 'Google', '["Google Calendar"]', '1 min read', 'published', '2006-03-08 11:27:44');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('SiteAdvisor plugin for safer browsing', 'siteadvisor-plug-in-for-safer-browsing', 'SiteAdvisor is wonderful plug-in for Firefox and Internet Explorer alike that automatically displays security notification about site being viewed. Simple color coding helps users…', '<a href="http://www.siteadvisor.com">SiteAdvisor</a> is wonderful plug-in for Firefox and Internet Explorer alike that automatically displays security notification about site being viewed. 
Simple color coding helps users quickly identify if the site is safe from spyware, spam, viruses and online scams. 

It is open to users to submit their own reviews and read what others have said about a particular website. It also rates search results from all major search engines making it even easier to detect potentially unsafe sites before opening them. 

It is not a security tool that can prevent spyware from auto installing if unsafe browser is used or block pop-ups. But it will arise users awareness about potential security issues in an easy way. As we know educating users counts for majority of internet safty efforts. 

Great job.', 'Security', '["Browsers", "Spyware", "Viruses"]', '1 min read', 'published', '2006-02-28 20:26:30');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Web Office Suite best products', 'web-office-suite-best-products', 'The appeal for use of Web based applications is very strong and here are some advantages: Simple to use Free or inexpensive Accessible from any computer with an internet access…', 'The appeal for use of Web based applications is very strong and here are some advantages:

<ul>
	<li>Simple to use</li>
	<li>Free or inexpensive</li>
	<li>Accessible from any computer with an internet access</li>
	<li>Operating system independent</li>
	<li>Nothing to install on local computer</li>
</ul>

An excellent review of office web applications is available <a href="http://blogs.zdnet.com/web2explorer/?p=123">here</a>.', 'Microsoft', '["Web 2.0", "Writley"]', '1 min read', 'published', '2006-02-22 21:47:19');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Web Services helping small businesses', 'web-services-helping-small-businesses', 'New York Times has great article on how small businesses are benefiting from expansion of Web services technologies that are making them more competitive. Read the article here .', '<a href="http://www.nytimes.com">New York Times</a> has great article on how small businesses are benefiting from expansion of Web services technologies that are making them more competitive. 

Read the article <a href="http://www.nytimes.com/2006/02/21/business/businessspecial2/21growth.html?ex=1298178000&amp;en=1c876b314e4786c5&amp;ei=5088&amp;partner=rssnyt&amp;emc=rss">here</a>.', 'Web 2.0', '["Web 2.0", "Web Services"]', '1 min read', 'published', '2006-02-22 09:12:05');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Comcast.net spam filter is bad', 'comcastnet-spam-filter-is-bad', 'If you are Comcast high speed internet service subscriber and use comcast.net email address then this complaint is for you too. I am sure you share the pain. I have guarded my…', 'If you are Comcast high speed internet service subscriber and use comcast.net email address then this complaint is for you too. I am sure you share the pain. 

I have guarded my comcast.net email address carefully in hope to protect it from getting flooded by spammers. I use it for some of my e-correspondence and not for subscriptions to newsletters or any other type of opt-in email marketing. I had been successful keeping it relatively spam free until about nine months ago. That is when I started receiving 2-3 pharmaceutical spam messages (Canadian pharmacy) and at least one for Rolex watches every single day. No exception. Today it is proportionally worse. Three or four of these always come straight into my inbox. Their spam filter is just incapable of catching what should be common spam by now. 

I have reported these messages as spam more times then anyone should need to. I have forwarded them to Comcast support for special handling or so I hoped. I am more then likely not in the minority of their subscriber base getting these. They just do not seem to be willing to do what it takes to block these messages. 

It bothers me that a company the size and capital such as Comcast is not willing to protect their paying customers. No wonder Gmail gained so much popularity so quickly.', 'Email', '["Comcast"]', '1 min read', 'published', '2006-02-13 20:11:16');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Google Desktop 3.0 released', 'google-desktop-30-released', 'Lately Google has been very active releasing upgrades to desktop web applications. The latest upgrade to Google Desktop brings it to version 3.0 . Those who have been using Google…', 'Lately Google has been very active releasing upgrades to desktop web applications. The latest upgrade to <a href="http://desktop.google.com/">Google Desktop</a> brings it to <a href="http://googledesktop.blogspot.com/2006/02/desktop-reloaded.html">version 3.0</a>. 

Those who have been using Google Desktop know that it offers quick way to search for desktop content along with web. It also offers ad-dons called panels that integrate into email, news, scratchpad, calendar, weather and <a href="http://desktop.google.com/plugins/">more</a>.

The newest feature is called "Search Across Computers" and if enabled allows Google desktop to store index of users desktop content on Google''s servers for search from other computers. Online stored index is accessible only to user who is uploading it. Search across computers isn''t comprehensive, but does cover a good range of file types, including:
<ul>
	<li>Web history (from Internet Explorer, Firefox, Netscape, and Mozilla)</li>

	<li>Microsoft Word documents</li>

	<li>Microsoft Excel spreadsheets</li>

	<li>Microsoft PowerPoint presentations</li>

	<li>PDF files in My Documents</li>

	<li>Text files in My Documents</li>

</ul>

While Google says users want the convenience of cross-computer file access from anywhere, privacy advocates are understandably concerned.', 'Google', '["Google Desktop"]', '1 min read', 'published', '2006-02-09 09:32:42');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Gmail Chat is coming', 'gmail-chat', 'NY Times has been braking top technology stories lately. The new program, called Gmail Chat , will let Gmail users exchange text messages with others without having to log onto a…', '<a href="http://www.nytimes.com">NY Times</a> has been braking top technology stories lately.


<blockquote>    The new program, called <a href="https://mail.google.com/mail/help/chat.html">Gmail Chat</a>, will let <a href="https://www.google.com/accounts/ServiceLogin?service=mail&amp;passive=true&amp;rm=false&amp;continue=http%3A%2F%2Fmail.google.com%2Fmail%2F%3Fui%3Dhtml%26zy%3Dl&amp;ltmpl=yule&amp;ltmplcache=2">Gmail </a>users exchange text messages with others without having to log onto a separate chat program, making instant messaging simpler and more integrated with the e-mail program.

    From anywhere in Gmail, the user can see who is available to chat. The program will also allow users to store instant-message conversations.</blockquote>

See more <a href="http://www.nytimes.com/2006/02/07/technology/07google.html?ex=1296968400&amp;en=94d57a25d17db102&amp;ei=5088&amp;partner=rssnyt&amp;emc=rss"> here</a>.', 'Google', '["Google Talk"]', '1 min read', 'published', '2006-02-07 13:20:25');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Email with priority delivery', 'email-with-priority-delivery', 'New York Times reported that Yahoo and AOL have proposed a priority email delivery system that will guaranty message delivery for quarter of cent per message. The model is similar…', '<a href="http://www.nytimes.com/2006/02/05/technology/05AOL.html?_r=1&amp;oref=slogin">New York Times</a> reported that Yahoo and AOL have proposed a priority email delivery system that will guaranty message delivery for quarter of cent per message. The model is similar to the one post office is using. 

Nicholas Graham, an AOL spokesman points out:

<blockquote>The last time I checked, the postal service has a very similar system to provide different options, where you really do get assurance that if what you send is important to you, it will be delivered, and delivered in a way that is different from other mail.</blockquote>

This has potential to change how email is used by businesses and should other email providers follow AOL and Yahoo, curbing overwhelming spam problem could become a long awaited reality.', 'Email', '[]', '1 min read', 'published', '2006-02-05 11:25:11');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Google baned BMW.de', 'google-baned-bmwde-2', 'The German website of BMW has been baned from Google index. BMW.de appears to have a PageRank of 0. A search for BMW Germany doesnâ??t show any sign of BMW.de at all. Just days…', 'The German website of BMW has been baned from Google index. BMW.de appears to have a PageRank of 0. A search for BMW Germany doesnâ??t show any sign of BMW.de at all. Just days ago BMW.de was ranked as top result. Instead, BMW.com â?? BMWâ??s international site â?? is on top for this search.

Speculations are that the site used illegal doorway page that was stuffed with keywords optimized with BMW marketing language. The trick is that this doorway page was only displayed to the Googlebot search index crawler. Human visitors were immediately redirected to another page upon visit without even noticing it. 

Google allows site search optimization for humans but not for robots. So it is a fair punishment.', 'Google', '["Cars"]', '1 min read', 'published', '2006-02-04 22:45:36');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('MS Office 2007 brings changes', 'ms-office-2007-brings-changes', 'The newest productivity suite from Microsoft is due for release early next year and will be named Microsoft Office 2007. The name is not surprising since Microsoft has been…', 'The newest productivity suite from Microsoft is due for release early next year and will be named Microsoft Office 2007. The name is not surprising since Microsoft has been following the same naming policy for long. More surprising is the fact that it took four years to build an upgrade to Office 2003. Many believe that Office products are Microsoft''s biggest cash cow. 

Apparently the new version is going to introduce some real changes to how it is used. Most noticeable is the switch from long branching pull down menus to new user results oriented interface. Practically it brings tabs in each of applications that display task related commands. With <a href="http://www.openoffice.org/">Open Office 2.0</a> being released and push to web based applications like <a href="http://www.writely.com/">Writely</a> starting to make inroads, MS has put more innovative thought into this version then  in previous releases.

Most people with older versions of Office do not upgrade until they buy new computer. MS is hoping that introduction of new techniques can speed up the upgrade push.

Screenshots and full review of Office 2007 can be found <a href="http://www.winsupersite.com/showcase/office12_inside.asp">here</a>.', 'Microsoft', '["Office 2007"]', '1 min read', 'published', '2006-01-25 20:58:43');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('News 2.0 services', 'news-20-services', 'There are more and more websites offering aggregation of news as service to subscribers. Some of them are free and others charge a small fee. News delivery is customized by user…', 'There are more and more websites offering aggregation of news as service to subscribers. Some of them are free and others charge a small fee. News delivery is customized by user chosen content making keeping up with news easier then ever.

<a href="http://tinfinger.blogspot.com/2006/01/feature-lists-for-news-20.html">Here</a> is comprehensive list of websites offering aggregated news delivery.', 'Web 2.0', '["News Aggregators", "Web 2.0"]', '1 min read', 'published', '2006-01-23 21:32:45');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Could BlackBerry go down?', 'could-blackberry-go-down', 'Well, given the latest developments with its legal trouble it could. But I doubt it. Because it is just too big and too many important people use it. I am sure there would be an…', 'Well, given the latest developments with its <a href="http://money.cnn.com/2006/01/23/technology/rim/index.htm?section=cnn_topstories">legal trouble</a> it could. But I doubt it. Because it is just too big and too many important people use it. I am sure there would be an uproar and a solution if the closure ever became immanent.', 'Email', '["BlackBerry"]', '1 min read', 'published', '2006-01-23 21:14:20');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Google News fully released', 'google-news-full-release', 'Google News is out of beta stage. The official release was today . After it first appeared a little over 3 years ago some would say Google took long to bring it out of beta, but…', '<a href="http://news.google.com/">Google News</a> is out of beta stage. The official release was  <a href="http://googleblog.blogspot.com/2006/01/and-now-news.html">today</a>. After it first appeared a little over 3 years ago some would say Google took long to bring it out of beta, but keep in mind that it is released for 22 regions in 10 languages.

Congratulations', 'Google', '["Google News"]', '1 min read', 'published', '2006-01-23 20:58:05');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Del.icio.us upgrade problems', 'delicious-upgrade-problems', 'If you are using del.icio.us daily you have more then likely noticed that it has been slow as of lately. Especially if you use more advanced features like tag rolls and link rolls…', 'If you are using del.icio.us daily you have more then likely noticed that it has been slow as of lately. Especially if you use more advanced features like tag rolls and link rolls to port your delicious links to your website and have easier access to it. As announced on thier<a href="http://blog.del.icio.us/blog/2006/01/finally.html"> blog</a> they were upgrading to better hardware that was suppose to allow roll-outs of new feature to make del.icio.us even better. 

But something happened and result of upgrades has meant more problems then benefits. I am sure they are working hard to get things right, but this is one more example how having our important data somewhere out there can be problematic. 

In order for these type of services to gain mass adoption they must prove that they are capable of providing consistent and reliable use at least 99.97 percent to early adopters. 

So far del.icio.us has shown less then that. I love their service and wonder why it took this long to get to this point. But you can not let problems last for 72 hours or more. And communication about issues must be far better then shown so far.', 'Web 2.0', '["del.ici.us", "Web 2.0"]', '1 min read', 'published', '2006-01-23 20:26:34');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('MAC OS installed on PC!', 'mac-os-installed-on-pc', 'It is well known that computing technology is always changing and improving. If it ever stopped being that way the whole world would be in trouble. But we all kind of knew that.…', 'It is well known that computing technology is always changing and improving. If it ever stopped being that way the whole world would be in trouble. But we all kind of knew that. Just how much and how fast these changes are taking place in front of our eyes is simply amazing. Here is an example. 

It is possible to install MAC computer operating system on PC! Yeah that PC that you bought from Dell, HP, Sony, Toshiba, etc., a year ago... with Windows XP installed. 

The latest MAC OS build is needed, which is X 10.4.3. For complete details and instructions how to do this please use this guide found on <a href="http://profit42.com/guides.php?id=1">profit42.com</a>.

I have always wondered when Apple was going to make this reality and start competing in the mainstream. I guess they were working on it while people were wondering. Lately a lot has been said about Apple switching to Intel based hardware but it was not known that their current software had been brought to that stage that it could run on PC today.

So what are the benefits? 
<ul>
	<li>There is going to be more competition. </li>
	<li>Competition means more choices.</li>
	<li>Choices result in better and chipper products.</li>
</ul>

Wonderful move by <a href="http://www.apple.com/">Apple</a>. Oh and by the way did you know that last week Apple''s market capitalization reached $72.13 billion, passing Dell''s value of $71.97 billion.', 'IT Tips', '["Intel", "IT Tips", "Mac OSX"]', '1 min read', 'published', '2006-01-17 20:06:13');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Google launches music search', 'google-music-search', 'Google launched music search without much of drumbeat. For now it provides search by artist, album and song listings with reviews from web. The search interface is designed in…', 'Google launched <a href="http://www.google.com/musicsearch">music search</a> without much of drumbeat. For now it provides search by artist, album and song listings with reviews from web. The search interface is designed in familiar Google theme, simple. 

I have no doubt that it will be effective. 

With this, <a href="http://www.apple.com">Apple</a> is getting more and more challengers for its market leading music sales business. <a href="http://www.yahoo.com">Yahoo</a> has positioned itself very well with it''s version of music store called <a href="http://launch.yahoo.com/">Yahoo Music</a>.

More choices just may push Apple to come out of the box called iTunes.', 'Entertainment', '["iTunes", "Yahoo Music"]', '1 min read', 'published', '2006-01-15 20:56:38');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('What is Google Pack?', 'what-is-google-pack', 'Google announced that it would offer set of software applications called Google Pack for free. It includes: Firefox, Ad-Aware, Norton Anti-virus, Adobe Reader plus many of…', 'Google announced that it would offer set of software applications called <a href="http://pack.google.com/">Google Pack</a> for free. It includes: Firefox, Ad-Aware, Norton Anti-virus, Adobe Reader plus many of Google''s desktop applications; Picasa, Google Earth, Desktop Search and the Google Toolbar for Internet Explorer.

The only application that is not indefinitely free of charge is Norton Anti-virus, it comes with 6 months of free deffintions updates. After that users will need to extend their subscription by purchasing service from Symantec. All other applications from Google Pack are free for download from thier manufacturers anyways. 

But it is beneficial to offer a package of essential software with update service called Google Updater that will monitor and automatically updated all services included in Google Pack. 

Not bad, but interesting to see Google move further inside users desktop.', 'Google', '["Google Pack"]', '1 min read', 'published', '2006-01-07 13:54:15');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Is TV over Internet reality?', 'is-tv-over-internet-reality', 'How great would it be to watch all TV content plus a lot more through internet connection? The reality of video content being delivered trough internet may not be as impossible…', 'How great would it be to watch all TV content plus a lot more through internet connection?

The reality of video content being delivered trough internet may not be as impossible and far fetched as it seems. This year''s International Consumer''s Electronics Show featured both, technological advances that will enhance video content delivery over internet and strong intention of biggest technology companies to enter the field and compete with cable and satellite service providers. 

Even though most of today''s television service companies own cable or phone line pipes to consumers'' home, it has been proven that "walled garden" of information delivery method is not sustainable. Consumers have simply chosen the freedom of controlling what they see and how they see information over having everything served in closed box portal way. AOL, Compuserve and MSN were pioneer ISPs and tried to preserve closed single channel information flow. We all know how they fared once other players entered the field. 

Having Microsoft, Google, Yahoo, Intel and oters take part in video content delivery service will speed up internet TV development. These companies already have well designed open standard information delivery that competes through quality of content. Today''s cable and satellite companies still hold monopoly when it comes to ways and means of reaching consumer''s homes. They also relay on it to keep consumers loyalty. This method will be shaken up and is going to face the same destiny telephone providers experienced as soon as internet infrastructure developed to carry voice service. 

Internet as video content delivery promises the same kind of quality television delivers, but better and with a lot more verity. We should see internet offer hundreds of thousands of channels instead of up to five hundred current service offers. Search for video content should be just as easy and convenient as searching internet is now. Price should also decrease.

How soon will all this be here? 

The main issue is delivery method. The bandwidth. Once internet connection is capable of delivering 10 megabits per second downstream or higher, we will have arrvied. Currently broadband service offers 1.5 - 6MB with cable providers clearly leading the way.

Internet Protocol TV (IPTV) may be closer then we think.', 'Internet', '["CES 2006", "IPTV"]', '2 min read', 'published', '2006-01-07 13:03:05');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('CES 2006 goodies', 'ces-2006-goodies', 'So CES 2006 is in full swing and there is plenty being promoted. Everyone had their ears set on Microsoft and Google. No there will be no Google PC, well not yet anyways, the…', 'So <a href="http://www.ces-show.com/2006/">CES 2006</a> is in full swing and there is plenty being promoted. Everyone had their ears set on <a href="http://www.engadget.com/2006/01/04/live-coverage-of-bill-gates-ces-keynote">Microsoft</a> and Google. No there will be no Google PC, well not yet anyways, the rumor was just another rumor. <a href="http://www.letsgodigital.org/html/review/apple/ipod_video/player_EN0.html">Apple</a> came out with another version of iPod with video palyback capability. 

But Skype, HP, Kodak, Sony also offered verity of technological gadgets. 
There is always one or two unexpected new comers that take some spotlight from big tech firms. Let''s see who they are this year.', 'Interesting', '["CES 2006"]', '1 min read', 'published', '2006-01-05 16:56:19');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Over one billion use internet?', 'how-many-people-use-internet', 'Internet use base has reached one billion. It will take another 10 years for that number to climb to two billion. But it took 36 years to get to first billion. Internet growth is…', 'Internet use base has reached one billion. It will take another 10 years for that number to climb to two billion. But it took 36 years to get to first billion. 

Internet growth is at 18% annual rate.

Demographic statistics are interesting: 

Asia 36%
Europe 24%
North America 23%

<a href="http://www.useit.com/alertbox/internet_growth.html">Useit.com</a> has interesting article about internet usability and growth.', 'Interesting', '[]', '1 min read', 'published', '2006-01-04 13:01:51');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Skype phone is out', 'skye-phone', 'I guess it was just matter of time before this came out. IPEVO and Netgear (available in 1st quarter of 2006) have released phones that that allow user of popular Skype service to…', 'I guess it was just matter of time before this came out. 

<a href="http://www.ipevo.com/free-1w.jsp">IPEVO</a> and <a href="http://tools.netgear.com/skype/">Netgear</a> (available in 1st quarter of 2006) have released phones that that allow user of popular <a href="http://www.skype.com/">Skype</a> service to make calls just like if they were doing it from their regular land or mobile phone. In some aspects it is even better, price wise firstly. 

Netgear phone will allow users to connect to their existing wireless home network removing the need to be connected to PC altogether. Skype application will come pre-installed and will allow contacts management from an interface similar to cell phones. 

Making calls to other Skype users is free around the world, while making calls to land line and cell phones is not, but costs very little.

Skype could be even better, I am waiting for a small device that I can attach to my mobile phone and use Skype service without being connected to anything else. So far there isn''t one yet.', 'Phone', '["Netgear", "Skype"]', '1 min read', 'published', '2006-01-03 13:29:23');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Firefox extentions advantage', 'firefox-extentions', 'Firefox has scored points with everyone who uses it for its implementation of add-ons called extensions. By opening itself for third party feature and enhancements integration, it…', 'Firefox has scored points with everyone who uses it for its implementation of add-ons called extensions. By opening itself for third party feature and enhancements integration, it has allowed users to participate in its development while keeping the core development simple and basic.

Extensions are probably single most reason for its popularity and fast user adoption.

Most popular and widely used extensions can be found on <a href="https://addons.mozilla.org/extensions/?application=firefox">Firefox Add-ons</a> site.

My must haves are: <a href="https://addons.mozilla.org/extensions/moreinfo.php?application=firefox&amp;id=722">NoScript</a>, <a href="http://adblockplus.mozdev.org/installation.html">AdblockPlus</a>, <a href="https://addons.mozilla.org/extensions/moreinfo.php?id=1136">Adblock Filterset.G Updater</a>, <a href="http://www.siteadvisor.com">SiteAdvisor</a>, <a href="http://ieview.mozdev.org/installation.html">IEView</a>, <a href="http://www.customizegoogle.com/">CustomizeGoogle</a>, <a href="http://toolbar.google.com/">GoogleToolbar</a> and <a href="https://addons.mozilla.org/firefox/1122/">TabMixPlus</a>.', 'IT Tips', '["Firefox", "IT Tips"]', '1 min read', 'published', '2005-12-31 11:54:05');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('IE in trouble..again', 'ie-in-troubleagain', 'It is well known that IE security has been compromised too often and made public loud and clear. The trend of switching to Firefox seems to pick up whenever one of these holes…', 'It is well known that IE security has been compromised too often and made public loud and clear. The trend of switching to Firefox seems to pick up whenever one of these holes gets uncovered.

Firefox also has some short comings but they do not seem to upset users nearly as much. Rebellion trend against the big guy (MS) is still cool way to think and act for some. Latest statistics give Firefox as much as 11% user base while IE is slowly losing its base. Slowest to switch are corporate users but that has started to change as well.

As long as there is competition we are all to benefit.', 'Microsoft', '["Browsers"]', '1 min read', 'published', '2005-12-31 11:36:34');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Mercedes is still the car to drive', 'mercedes-most-rapped-about-brand-in-2005', 'We all want one, don''t we? Rappers sing about it, oh so often. I do too!!!', 'We all want one, don''t we?

<a href="http://money.cnn.com/2005/12/30/Autos/rap_brands/index.htm">Rappers sing</a> about it, oh so often.

I do too!!!', 'Interesting', '["Cars"]', '1 min read', 'published', '2005-12-31 03:15:41');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('K2 theme for Wordpress', 'k2-theme-for-wordpress', 'Definitely the best theme. You are reading this article with it as of 12/30/05.', 'Definitely the best theme.

You are reading this article with it as of 12/30/05.', 'Blogging', '[]', '1 min read', 'published', '2005-12-30 23:10:01');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Web 2.0 and the big ones', 'web-20-and-big-ones', 'One can not help but wonder if big corporations will start changing their web pages that typically consists of: A nested navigational structure with no way to find out which parts…', 'One can not help but wonder if big corporations will start changing their web pages that typically consists of:

<ul>
    
	<li>A nested navigational structure with no way to find out which parts have changed,</li>
	<li>A lonely press release corner titled "News",</li>
	<li>Practically no external links unless the site linked to is an official partner in some way</li>
	<li>A hypothetical "front-door navigation path" approach to usability, which is so 2000,</li>
	<li>No signatures or date stamps below articles,</li>
	<li>Advertisement bogus content, which no one cares to read about.</li>
</ul>

It is time to integrate with the world of blogs, podcasts, RSS, etc., and replace their "Web 1.0 homepages" with it. The most important part of all of this, next to the technical buzzwords, is really about direct communication from people within the company to the people reading along on the web.

They have the resources necessary bring Web 2.0 faster then progressive army of tech enthusiasts who are pushing it now.', 'Open Source', '["Open Source", "Web 2.0"]', '1 min read', 'published', '2005-12-30 23:00:33');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Which Linux Distro Is Best For You?', 'which-linux-distro-is-best-for-you', 'Most popular Linux distributions Ubuntu, Redhat, Debian, Ubuntu, Mandriva, SuSe. It all depends what your do with it and how well you know it. Ubuntu seems to be the easiest to…', 'Most popular Linux distributions Ubuntu, Redhat, Debian, Ubuntu, Mandriva, SuSe. It all depends what your do with it and how well you know it. Ubuntu seems to be the easiest to install and obtain good software for. But if you know what you are doing and need top of the line box then Redhat is still your choice.

Other will have different opinions but this is mine, just like distribution writers like to do things a bit differently then the next guy.', 'Open Source', '["Linux", "Open Source"]', '1 min read', 'published', '2005-12-30 22:49:50');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Xbox vs. PS, who is winning', 'xbox-vs-ps', 'Is the game over? Some would say Microsoft has already overtaken Sony in hearts and minds of gaming folks. While the game is not over yet, Microsoft has made huge strides to…', 'Is the game over?

Some would say Microsoft has already overtaken Sony in hearts and minds of gaming folks. While the game is not over yet, Microsoft has made huge strides to getting to that point. Latest version of Xbox is certainly holiday special buy for many while Sony is still working on its answer to Microsoft''s HD capable gaming wonder. 

We will now by the next release of each device which one will be more sought after.', 'Entertainment', '["Play Station", "Xbox"]', '1 min read', 'published', '2005-12-30 22:32:25');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Product quality vs. brand recognition', 'product-quality-vs-brand-recognition', 'In today''s marketing crazy world good brand can still bring a ton of money to corporations. But there are some changing trends that can be seen taking hold in consumer mind. For…', 'In today''s marketing crazy world good brand can still bring a ton of money to corporations. But there are some changing trends that can be seen taking hold in consumer mind. For example; rapid success of new product and their mass adoption leads to believe that quality is becoming more important then recognition.

Take two great product that enjoyed wild success almost from the start; <a href="http://www.google.com">google</a> and <a href="http://www.skype.com">skype</a>. Their becoming part of our life was an overnight process.

But not everyone has learned, SBC recently acquired AT&amp;T and is preparing to spend $1 billion on rebranding. Good luck.', 'Interesting', '[]', '1 min read', 'published', '2005-12-30 22:22:20');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('The phenomena of social bookmarking', 'social-bookmarking-is-convinient', 'Not so long ago, in 2nd half of 2003 more precisely, the phenomena known as social bookmaking ( What is it anyway ) took off and continues to grow. del.icio.us was the pioneer in…', 'Not so long ago, in 2nd half of 2003 more precisely, the phenomena known as social bookmaking (<a href="http://en.wikipedia.org/wiki/Social_bookmarking">What is it anyway</a>) took off and continues to grow.

<a href="http://del.icio.us/">del.icio.us</a> was the pioneer in this movement and was acquired by Yahoo which aggressively entered the field of social Internet activity and helped push it forward.

There are other players in this field which provide more convenience and better features along with faster access. Two better once are <a href="http://www.simpy.com">Simpy</a> and <a href="http://www.shadows.com">Shadows</a>.', 'Web 2.0', '["Social Bookmarking", "Web 2.0"]', '1 min read', 'published', '2005-12-30 18:29:15');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Web 2.0, do you use it?', 'web-20-do-you-use-it', 'Do you use Web 2.0? Not sure... What is Web 2.0? The easiest answer would be next version of today''s World Wide Web. True. better definition can be found here: Wiki Web 2.0 . Do…', 'Do you use Web 2.0? Not sure... What is Web 2.0? The easiest answer would be next version of today''s World Wide Web. True. better definition can be found here:
<a href="http://en.wikipedia.org/wiki/Web_2.0">Wiki Web 2.0</a>.

Do you visit any of these websites or use their services, most of them free of charge BTW:
<ul>
	<li><a href="http://www.bloglines.com/">Bloglines</a>, Web based RSS feed content reader</li>
	<li><a href="http://del.icio.us/">Del.icio.us</a>, free, social bookmarking community</li>
	<li><a href="http://www.flickr.com">Flickr</a>, store your photos and share with anyone, easy</li>
	<li><a href="http://tech.memeorandum.com/">Memorandum</a>, blogshare content scan</li>
	<li><a href="http://www.netvibes.com/">Netvibes</a>, free <a href="http://en.wikipedia.org/wiki/AJAX">AJAX</a> based home page with news feeds</li>
	<li><a href="http://www.omnidrive.com.au/">Omnidrive</a>, functional online storage product with some web 2.0 features</li>
	<li><a href="http://www.skype.com/">Skype</a>, IP telephony for everyone</li>
	<li><a href="http://www.technorati.com/">Technorati</a>, blogs search engine, works well</ul></li>

This kind of services are Web 2.0 today, extremely easy to use, cost next to nothing, customizable.

Want to know more, <a href="http://www.web2con.com/">Web 2.0 Conference</a> has all you need to know.', 'Web 2.0', '["Web 2.0"]', '1 min read', 'published', '2005-12-30 17:17:14');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Windows explorer focus customization', 'windows-explorer-focus-customization', 'Control Windows Explorer Focus Ever wish you could control the folder or drive that Windows Explorer opens to? Well, you can and here''s how: Right-click the Desktop and select…', '<strong>Control Windows Explorer Focus </strong>

Ever wish you could control the folder or drive that Windows Explorer opens to? Well, you can and here''s how: 

Right-click the Desktop and select New, Shortcut. 
In the command line box, put in one of the commands below: 

1. To have this shortcut open Explorer with focus on the My Documents folder, use this in the command line (probably a good idea to copy and paste the line): 
explorer /e,/n,/root, c:\My Documents

NOTE: XP users will need to insert your user name for a My Documents shortcut. Your command line needs to look like this: 
explorer.exe /e,/n,/root, C:\Documents and Settings\ YOUR USER NAME \My Documents 

2. If you would like to just have focus on the C: drive, use the line below: 
explorer /e,/n,/root, c:\ 
3. If you would like the shortcut to open to a "My Computer" view, use this line: (Note - if you right-click My Computer and select Explore from the resulting menu, you''ll get the same effect. This is quicker though) 
explorer /n,/e,/root,,/select,C:\ 

NOTE: As you can see, you can put in any path you like where you see the "C:\ " at the end of the line. You could set up Explorer shortcuts for any frequently used folders and or drives. 
Once you''ve decided on the command line, click Next and name the shortcut (something like "Explore My Stuff" or Explore My Docs") and click the Finish button.', 'IT Tips', '["IT Tips"]', '1 min read', 'published', '2005-12-30 14:36:54');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Negotiating tips for everyone', 'negotiating-tips', 'Following are some important tips that may help you in your negotiations when purchasing a car: Always negotiate price, never monthly payments Always negotiate price UP from…', 'Following are some important tips that may help you in your negotiations when purchasing a car:

<ul>
	<li>Always negotiate price, never monthly payments</li>
	<li>Always negotiate price UP from dealer''s cost, not DOWN from the sticker price</li>
	<li>Never let the dealer tell you that lease prices are not negotiable</li>
	<li>Never, ever tell the dealer what monthly payments you can afford</li>
	<li>Always come prepared with the dealer invoice price for the vehicle you want</li>
	<li>Always come knowing what your trade-in is worth</li>
	<li>Never let the dealer tell you your source of invoice prices is wrong</li>
	<li>Never, ever give the dealer a deposit on a car during negotiations</li>
	<li>Never give the dealer a chance to "lose" the keys to your trade-in</li>
	<li>Don''t sign any kind of "purchase/lease agreement" until you''ve settled on a deal</li>
	<li>Never reveal your attraction to a vehicle ("I just love that car") during negotiations</li>
	<li>If you''re not comfortable with the salesperson, ask for another, or leave</li>
	<li>Always give yourself the option of walking out if negotiations don''t go your way</li>
	<li>Let the dealer know up front that you are knowledgeable about leasing</li>
	<li>If you sense the salesperson is playing games with you, ask them to stop</li>
	<li>Don''t agree to extended warranties, credit insurance, or add-on services</li>
	<li>Always check the dealer''s monthly payment figures against your own figures</li>
	<li>Generally, it''s best to deal at the end of the day, at the end of the month, on a weekday, on a rainy day, or any slow period</li>
	<li>Never accept an offer to take a car home overnight before you''ve settled a deal</li>
	<li>If you become tired, confused, intimidated, or pressured during negotiations, you''re doomed</li>
</ul>', 'Career Tips', '[]', '1 min read', 'published', '2005-12-30 14:10:17');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Are you "digging" yet?', 'digg', 'digg is a new kind of news content publisher.; "Technology focused news site where the stories are chosen by community members rather than editors." Sounds promising, who better…', '<a href="http://www.digg.com">digg</a> is a new kind of news content publisher.;


<blockquote>"Technology focused news site where the stories are chosen by community members rather than editors." </blockquote>

Sounds promising, who better to determine what matters to readers but readers themselves.

Check it out.', 'Blogging', '["Digg"]', '1 min read', 'published', '2005-12-29 23:32:01');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Wordpress 2.0 is official', 'wordpress-20-is-official', 'If you have been waiting for Wordpress 2.0 release, then the wait is over. It has been released and this blog is running on it. I looks pretty good so far. Wordpress is an…', '<p>If you have been waiting for Wordpress 2.0 release, then the wait is over. It has been released and this blog is running on it. I looks pretty good so far.</p>
<p>Wordpress is an excellent blogging software, easy to use, manage and maintain. You can download it here:</p>
<p><a href="http://wordpress.org/download/">Wordpress</a></p>

<br>

<p>Happy blogging</p>', 'Blogging', '["Wordpress"]', '1 min read', 'published', '2005-12-26 23:25:04');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Connecting Mac OS X to a Win 2003 Server', 'mac-os-x-connecting-to-a-win-2003-server', 'Problem: When the Mac users connect to server, they can see the domain and the server, but the authentication process seems to fail with error: "connecting to smb:/[ip address].…', '<strong>Problem:</strong>
When the Mac users connect to server, they can see the domain and the server, but the authentication process seems to fail with error: "connecting to smb:/[ip address]. An error occurred (error= -5000)"

<strong>Resolution:</strong>
Seems like you need to make a registry change on the Windows 2003 box.

HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters

The value of RequireSecuritySignature needs to be changed from ''1'' to ''0''.

One note: If this is a domain controller, you will need to set it with the ''Domain Controller Security Policy'' editor under the ''Administrative Tools'' Menu. Otherwise it''ll be reset nightly.

You need to go to ''Security Settings'', ''Local Policies'', ''Security Options''. You then need to set the ''Microsoft network server: Digitally sign communications'' to disabled. It is enabled by default.', 'IT Tips', '["IT Tips", "Mac OSX"]', '1 min read', 'published', '2005-11-30 15:42:48');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('How To Edit Files and Folders Right Click Menu Items', 'how-to-remove-and-add-right-click-menu-items-from-files-and-folders', 'Removing Items A lot of programs you install will add themselves to the right-click menu of your files and/or folders. And most times, you have no choice in the matter and, as a…', '<strong>Removing Items</strong>
A lot of programs you install will add themselves to the right-click menu of your files and/or folders. And most times, you have no choice in the matter and, as a result, your right-click menu can get very long with added items you don''t even use. The last person I was helping with this had a right context menu so long that the Rename option was no longer visible!
Fortunately, you can easily remove those unwanted menu items, if you know the registry values to edit. And it''s not at all difficult once you know the keys responsible for the additions.

For Files, the secret lies in the "context menu handlers" under the shellex subkey for "All Files" which, in the registry, is nothing but an asterisk - like a dos wildcard, which means the values entered apply to all files. It is at the very top of the Root key, right here:

HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers

Click the the + sign next to the ContextMenuHandlers key, to expand it.
Now you will see some of the programs that have added items to your right-click menu. Simply delete the program keys you don''t want. 
Yup! It''s that simple. If deleting makes you uneasy, just export the key before deleting it. Or, instead of deleting the values, disable them. Simply double click the default value for the program on the right hand pane and rename the clsid value by placing a period or dash in front of it.
ie;    - {b5eedee0-c06e-11cf-8c56-444553540000}
Then exit the registry, refresh, and right click a file to see if the item was removed from the menu.
Some programs - like WinZip or WinRar - will add several items to your right click menu but all of them will be removed by deleting or disabling their one context menu handler. 

Note that the above key only applies to the right click menu of files.
To remove entries from the right click context menu of folders, you need to navigate to the Folder and Drive keys:

HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers
HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers

All you have to do is follow the same procedure as for Files - either disable or delete items you wish to remove.


<strong>Adding Items</strong>
Adding Items to the right click menu of Files and Folders is also fairly simple using the Registry. It just involves the creation of a few new keys for each item you wish to add. You edit the same keys used for removing items. Let''s use Notepad as an example of an item you''d like to add to the right click menu of all your files or folders.

For folders, go to this key:
HKEY_CLASSES_ROOT\Folder
Click the + sign next to Folder and expand it so that the Shell key is visible. Right click the Shell key and choose New&gt;Key and name the key Notepad or whatever else you''d prefer (whatever the key is named is what will appear in the right-click menu).  Now right click the new key you made and create another key named Command. Then, in the right hand pane, double click "Default" and enter Notepad.exe as the value.
Exit the registry, refresh, and right click any folder. Notepad should now be on the context menu.


For files, go here again:

HKEY_CLASSES_ROOT\*
Expand the * key and see if a Shell key exists. If it does exist, follow the same procedure as for folders. If it does not exist, you''ll have to create a new Shell first. Just right click the * key and choose New&gt;Key and name it Shell. Then right click the Shell key and continue on the same way you did for adding items to the right click menu of folders.
Once done, Notepad should appear as an option in the right click menu of all your files.', 'IT Tips', '["IT Tips"]', '3 min read', 'published', '2005-11-30 15:35:59');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Windows XP performance tweaking guide', 'windows-xp-performance-tweaking-guide', 'You are responsible for any changes made to your computer. Performance Increase through My Computer Easy enough tweak to usually find out about it on your own, but still, some of…', 'You are responsible for any changes made to your computer.

<strong>Performance Increase through My Computer</strong>
Easy enough tweak to usually find out about it on your own, but still, some of use still don''t find it right away. So here it is: 
1: Start &gt; Right Click on My Computer and select properties. 
2: Click on the "Advanced" tab 
3: See the "Performance" section? Click "Settings" 
4: Disable the following: 

Fade or slide menus into view 
Fade or slide ToolTips into view 
Fade out menu items after clicking 
Show Shadows under menus 
Slide open combo boxes 
Slide taskbar buttons 
Use a background image for each folder type 
Use common tasks in folders 

There, now Windows will still look nice and perform faster.

<strong>Shutdown XP faster</strong>
Like previous versions of windows, it takes long time to restart or shutdown windows xp when the "Exit Windows" sound is enabled. to solve this problem you must disable this useless sound.

click start button then go to settings -&gt; control panel -&gt; Sound,Speech and Audio devices -&gt; Sounds and Audio Devices -&gt; Sounds, then under program events and windows menu click on "Exit Windows" sub-menu and highlight it.now from sounds you can select,choose "none" and then click apply and ok.
now you can see some improvements when shutting down your system.

<strong>Speeding up your pentium 2 by 50%</strong>
We all know that you really shouldn''t try to run Windows XP on anything less than a Pentium 3 of some sort if you are out for speedy operations and amazing reaction times, but for those of us with the good old Pentium 2''s who want to see just how well we can run XP, we have to tweak as much as we can where-ever we can. A real killer to the system''s performance is Windows Media Player. Although it may look desirable and fancy with it''s rounded off edges and 3rd-Dimensional appearance, the truth is, it takes up a large amount of that precious processing power. All of these troubles however, lead to one thing in particular with this ''new-look'' over-rated music and video player...the Visualisations. The look-great i''ll admit but like a lot of software these days, it has no purpose. If you run the task manager, and click the Performance tab along the top, you''ll see that when Windows Media Player is running and nothing else is active, it takes up around 50% of the processors power. Once these visualisations are turned off, it barely takes up 2-3% of the processors power, which leaves much more room for other applications to work efficiently. Here''s how to disable the feature:

1. Open Media Player
2. Make sure the Now Playing tab on the left is selected.
3. Click the View menu along the top.
4. Go down to Now Playing Tools
5. In the sub-menu that has just ''popped-out'', uncheck Show Visualisation.

It''s a very simple process and a little boring without the colorful graphics - but then no-one said computing was easy! 

<strong>Shutdown XP Faster</strong>
When a user shuts down Windows XP, first the system has to kill all services currently running.  Every once in a while the service does not shut down instantly and windows gives it a change to shut down on its own before it kills it.   This amount of time that windows waits is stored in the system registry. If you modify this setting, then windows will kill the service earlier.  To modify the setting, follow the directions below:
1.	Start Regedit. 
2.	Navigate to HKEY_LOCAL_MACHINE/SYSTEM/CurrentControlSet/Control. 
3.	Click on the "Control" Folder. 
4.	Select "WaitToKillServiceTimeout" 
5.	Right click on it and select Modify. 
6.	Set it a value lower than 2000 (Mine is set to 200).

<strong>Speed up Detailed view in Explorer</strong>
If you like to view your files in Windows Explorer using the "Details" view here is a tweak to speed up the listing of file attributes:

Viewing files in Windows Explorer using the "Details" mode shows various attributes associated with each file shown. Some of these must be retrieved from the individual files when you click on the directory for viewing. For a directory with numerous and relatively large files (such as a folder in which one stores media, eg: *.mp3''s, *.avi''s etc.) Windows Explorer lags as it reads through each one. Here''s how to disable viewing of unwanted attributes and speed up file browsing:

1. Open Windows Explorer
2. Navigate to the folder which you wish to optimize.
3. In "Details" mode right click the bar at the top which displays the names of the attribute columns. 
4. Uncheck any that are unwanted/unneeded.

Explorer will apply your preferences immediately, and longs lists of unnecessary attributes will not be displayed.
Likewise, one may choose to display any information which is regarded as needed, getting more out of Explorer.

<strong>Easily Disable Messenger</strong>
Go into: C:/Program Files/Messenger. Rename the Messenger folder to "MessengerOFF" This does not slow down Outlook Express or hinder system performance.

<strong>Turn off System Restore to save space</strong>
By default, Windows XP keeps a backup of system files in the System Volume Information folder. This can eat up valuable space on your hard drive. If you don''t want Windows to back up your system files:

1. Open the Control Panel
2. Double-click on system
3. Click the System Restore tab
4. Check "Turn off System Restore on all drives"
5. Hit Apply
6. You may now delete the System Volume Information folder.

Warning! If you turn this off you will not be able to use Windows System Restore to restore your system in case of failure.

<strong>Fresh Install with no ACPI (updated)</strong>
Here is an easier way to do the Fresh Install with no ACPI. When setup is loading, the blue screen will ask if you have any raid devices, and to press F6. When it does that, press and hold F7, &amp; Congratulations! No ACPI will be installed.

<strong>Increase ''CPU priority tweak'' effect</strong>
First you must set the CPU Priority setting tweak.Using ''Regedit'', go to this location:"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl\" and set the "Win32PrioritySeparation" to "38" 

The last adjustment is to set the "Launch folder windows in separate process" setting by opening the "My Computer\Tools\Folder Options\View -and tick the "Launch folder windows in separate process" box.

Window XP will open any new window(including program) in its own memory and in separate process priority.(increase stability and speed but use much more RAM than before)

Note:
Sometimes this 2 tweak can cause unresponsive keyboard and mouse in Counter-Strike. 

<strong>Very slow boot when networking</strong>
On some XP Pro installations, when connected to a network (peer-peer in this case), the computer boot time is over 1:40. The system seems to freeze after logging in and the desktop may not appear or will freeze for a minute. As timed with the utility, Bootvis.exe, the problem was with the driver mrxsmb.dll, adding over 67 seconds to the boot time. Turning off and restoring file and printer sharing eliminated 65 seconds from the boot time.

1. Alt-click (or right click) on Network Places &gt; Properties
2. Alt-click on Ethernet Adapter connection &gt; properties
3. Un-check "File and Printer Sharing for Microsoft Networks" &gt; OK
4. reboot
5. If you need file or printer sharing, repeat the above, re-check the box and re-boot again.

<strong>Disable Virtual Memory</strong>
On a system with little memory (less than 512mb), the swap file (or page file) is a large file on your hard drive that temporarily holds blocks (or pages) of real memory while another task has focus. In the past, this has been a good thing as memory has been very expensive, while hard disk storage has been relatively cheaper.

BUT IT''S SLOW.

Every time you start a task on an untweaked system, then a lot of the disk activity isn''t your program loading into memory, it''s the current program''s memory being paged out to disk. This takes time, but generally it''s a good trade, extra virtual memory for the cost of a short wait.

There are a few ways of increasing the performance of your system related to your swap file. With a default system, the swap file is allowed to shrink and grow according to how many programs are in use. Over time, with increased disk usage, it can become fragmented, so that it takes longer to page memory in and out as the drive head moves backwards and forwards picking up a file fragment here and there. If you fix the size of the swap file by setting it manually, a contiguous section of your hard drive is allocated by windows. There is no way that this can now become fragmented (and therefore slower), as it takes up a fixed area on your hard drive.

To get a further speed improvement, if you have a second PHYSICAL drive (not a partition), and most of your programs are stored on your primary drive, then you can allocate the swap file to the second drive. Now you benefit from having one drive manage the swap file, while the other manages your program loading.

The third method of improving performance is to switch the damn thing off altogether. If you have more than 512mb of RAM (I guess that''s a lot of people nowadays), you can disable the swap file as Windows will insist on using it even when it''s unnecessary. Well, the way I look at it is, why use virtual memory when you have the real thing? Real memory is a LOT faster than a swap file, and one day hard drives may become defunct as memory technology improves.

I have 640mb RAM in my system, and the swap file is disabled. It''s pretty quick at loading programs - the amount of disk access is noticeably reduced. Even when I have a lot of programs open, I still have a couple of hundred megabytes to spare.

Anyway, that''s the background, now how to do it.

1. Open up Control Panel.
2. Double click System.
3. Click on Advanced tab.
4. Click on "Settings" button of Performance section.
5. Click on Advanced tab.
6. Click on "Change" button of Virtual Memory section.

7. Now depending on what you want to do, you can alter the size and location of the swap file by clicking on "Custom size" and the desired drive, or you can just click on "No paging file".

8. Click the "Set" button.
9. Ok, Ok, Ok.
10. Reboot.

Now for the disclaimer.

If you set things up wrong, you could end up with A SYSTEM THAT WON''T BOOT. Be very careful about the settings you choose for a static swap file. There is probably a good formula along the lines of using twice the size of your RAM for the swap file. I don''t think you could go too wrong if you set it to 512mb. Windows has some simple method of working it out which I think is based on one and a half times your RAM. This clearly doesn''t make sense, as if you had 4gb RAM, why would you even need a 6gb swap file?

As I said above, my system works fine without a swap file, it has 640mb RAM, but worked for about two months with 512mb and no swap file, so I know that configuration is fine, but then I keep my system pretty lean anyway, no unnecessary programs running in the background (Real player, MS Messenger, Anti-Virus etc.). I check for viruses manually every Friday, keep on top of security fixes, and never run anything dodgy. If my system suddenly decides to do anything on it''s own, I find out what it is and kill it (Real player, MS Messenger, Anti-Virus etc. hehe).

Have fun, and don''t blame me if you break something, you do this at your own risk.

<strong>Ramdrive in XP</strong>
Remember good old ramdisk. Implementing it in a 9x kernel box is easy. But what about in an XP box? Or more importantly, why the heck would you? Well, if your a paranoid internet surfer that does not want your surfing habits left on your machine. You can redirect your temp cache to the ramdrive. Any sensitive files/folders (Those wonderful ~*.tmp that Office creates) that you want washed away on reboot. I''m sure there are other uses. 

Instructions: 

Get the software from here: 

<a href="http://support.microsoft.com/default.aspx?scid=kb;en-us;Q257405&amp;SD=MSKB&amp; ">RAM Drive in XP</a>

Install the software as a new hardware device (Add New Hardware) using the advanced install wizard to point to the .inf 

Change these registry keys 

HKLM\SYSTEM\CurrentControlSet\Services\Ramdisk\Parmeters 

DiskSize change to 01F00000 (32505856) 

HKLM\SYSTEM\CurrentControlSet\Services\Fastfat\Start 

Start change from 4(disabled) to 1(system) 

Reboot 

The only limitation is that the drive can only be 32MB in size. :( 

<strong>Easy Way to Adjust LargeSystemCache</strong>
Normally, the tweak I''ve seen asks you to go into HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management and change the value to either O or 1 to the adjustment the
LargeSystemCache.

However, in Windows XP, all you have to do is:

1. Right click My Computer
2. Select Properties
3. Click Advanced
4. Choose Performance
5. Click Advanced again
6. Select either Programs or System Cache under Memory Usage.

Programs = 0 for the registry tweak equilavent
System Cache = 1 for the registry tweak equilavent

On NT Server (in this case XP), the Large System Cache option is enabled, but disabled on Workstation. The two different settings effect how the cache manager allocates free memory. If the Large Cache option is on, the manager marks all the free memory, which isn''t being used by the system and/or applications, as freely available for disk caching. On the flip-side (with a small cache), the manager instead only sets aside 4MB of memory for disk caching in an attempt to accelerate the launch of applications. Or in a more technical approach, if enabled the system will favor system-cache working sets over process working sets (with a working set basically being the memory used by components of a process).

<strong>XP Automatic Shutdown</strong>
This tweak enables XP to turn off your computer automatically at shutdown.

1. Goto /Start/Control Panel/Performance and Maintenance/System.
2. Select the Hardware tab and then select Device Manager.
3. Under the ''View'' menu select Show Hidden Devices. Double click NT/Apm/Legacy Interface
Node and enable device. De-select show hidden devices again and re-boot.

Now your PC will shutdown automatically just like good old Windows 98.

Slow start-up when using Norton Internet Security 2002
If you are using Norton Internet Security 2002, and are experiencing slow start-up of XP. 

i.e. you can see the desktop with icons etc. but it takes 30-60sec before you can start using the computer.

1. Click on start buttom.
2. Select control panel
3. Open â??Network Connectionsâ?
4. Under â??LAN and High-Speed Internetâ?, right-click on your â??Local Area Connectionâ? and select â??Propertiesâ?
5. Under â??Generalâ? tab, select â??Internet Protocol (TCP/IP)â? and select â??Properties.
6. Select â??Use the following IP address:â? 
7. Under â??IP addressâ? enter following : 192.168.0.1
8. Under â??Subnet Mask:â? enter following : 255.255.255.0
9. Click â??Okâ?

<strong>Correcting System Hang at Startup</strong>
If your system hangs about 2 or 3 minutes at startup, where you can''t access the Start button or the Taskbar, it may be due to one specific service (Background Intelligent Transfer) running in the background. Microsoft put out a patch for this but it didn''t work for me. Here''s what you do:

1. Click on Start/Run, type ''msconfig'', then click ''OK''.
2. Go to the ''Services'' tab, find the ''Background Intelligent Transfer'' service, disable it, apply the changes &amp; reboot. 

<strong>Windows XP does have a back-up Utility!!!</strong>
Insert your windows XP disc into your PC. Click exit if your installation screen comes up. Now go too your CD drive in *My Computer*. Right-click and select open. Choose VALUE ADD\MSFT\NT BACK-UP FILE. In the *files of type* drop down list be sure that *select all files* is on. Click on the NTBACK-UP.msi file and click okay. Click the finish button and now go over too the start button\ALL PROGRAMS\ACCESSORIES\SYSTEM TOOLS\ and there it is now.. BACK-UP FILES...Great little tool that Microsoft never should have hidden.

<strong>Clicking AVI Files on explorer casuing 100% CPU Usage </strong>
Well windows seem to have a REALLY big problem when it comes to reading AVI files. It seems that when you click on an AVI file in explorer, it''ll try to read the entire AVI file to determine the width,height, etc. of the AVI file (this is displayed in the Properties window). Now the problem with Windows is that if you have a broken/not fully downloaded AVI file that doesnt contain this info, Windows will scan the entire AVI file trying to figure out all these properties which in the process will probably cause 100% CPU usage and heavy memory usage.

To solve this problem all you have to do is the following:

1. Open up regedit
2. Goto HKEY_CLASSES_ROOT\SystemFileAssociations\.avi\shellex\PropertyHandler
3. Delete the "Default" value which should be "{87D62D94-71B3-4b9a-9489-5FE6850DC73E}"

Voila! Please not that this will no longer provide you with the windows properties displaying the AVI file information such as width, height, bitrate etc. But its a small price to pay for saving you resources.

NOTE: Please use caution when using regedit. Improper usage may cause windows to behave imcorrectly. Also, I cannot be held resposible. Backup your registry first.

<strong>CDFS Tweaks</strong>
Howdy all........Whats the one thing we hate most when copying something from CD, for me at least, is the speed in which the data is copied.

After many months of research, I have found what I consider the best CDFS settings to have, and my DVD drive never copied so good ;)

Here are the changes that must be made:

- HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem\CDFS
- Look for that registry key, if not there, we must create a new key, then add the following values
- CacheSize, this must be added as a binary value, then type in this value: ff ff 00 00
- Prefetch, this key must be added as a DWORD value, then type in this value: 4000 hex
- PrefetchTail, this key must be added as a DWORD value, then type in this value: 4000 hex

After that tweaking, try copying something across from CD, and you will notice it does produce a speed boost, but it becomes apparent after a while of using this tweak, you may or may not see it at first.

Let the ripping begin ;)

<strong>Disable XP Boot Logo</strong>
It is possible to disable XP splash screen, which will slightly speed up the overall boot process. Be aware that removing the splash screen will also cause you not to see any boot-up messages that might come up (chkdsk, convert ... ), but if your system runs without any problems then it should not matter.

1. Edit boot.ini
2. Add " /noguiboot" right after "/fastdetect".

Upon restarting, the splash screen will be gone. It can be re-enabled by removing the new switch.

<strong>Slow network access not always due to Scheduled tasks check</strong>
If you have very slow access to your network computers through "My network Places" and have already deleted the Registry entry calling for a check of Scheduled Tasks on the other network computers (documented elsewhere on this site) AND you have multiple network adaptors (i.e. a cable or DSL connection through one NIC and an internal network using a second NIC) check the following.

Right click on "My Network Places", go to properties. Right click on the NIC that your cable/DSL connects to, and chose properties. Select Internet Protocol (TCP/IP), and click on properties. Click on "advanced", go to "WINS" tab, and chose Disable NetBios over TCP/IP.

When you are back at your Network Connections page, right click on the Broadband selection, chose "properties" click on the networking tab. Again, chose TCP/IP, properties, advanced, WINS, and select "disable NetBios over TCP/IP"

Worked for me!

BTW, I don''t use ICS (can never get it configured right) and instead use Sygate for my Connection Sharing, so I can''t verify that with ICS netbios is enabled in the broadband connection and the modem NIC.The Wizard might catch it, but take a look just in case.

<strong>Increase speed by tweaking prefetcher settings</strong>
This is an unique technique for XP, which could improve the performance significantly by tweaking the prefetcher. Recommended hardware: PIII 800 or higher, 512M RAM or more.

1. run "regedit";
2. goto [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters\EnablePrefetcher];
3. Set the value to either 0-Disable, 1-App launch prefetch, 2-Boot Prefetch, 3-Both ("3" is recommended). 
4. reboot.

It will decrease the boot time but double and increase the performance of your XP. Try it!

<strong>Turn off Indexing to speed up XP</strong>
Windows XP keeps a record of all files on the hard disk so when you do a search on the hard drive it is faster. There is a downside to this and because the computer has to index all files, it will slow down normal file commands like open, close, etc. If you do not do a whole lot of searches on your hard drive then I suggest turnning this feature off:

1. Open my computer
2. Right click your hard drive icon and select properties.
3. At the bottom of the window you''ll see "Allow indexing service to index this disk for faster searches," uncheck this and click ok.
4. A new window will pop up and select apply to all folders and subfolders. It will take a minute or two for the changes to take affect but then you should enjoy slightly faster performance. 

<strong>Clean your prefetch to improve performance</strong>
This is an unique technique for WinXP. We know that it is necessary to wash registry and TEMP files for Win9X/ME/2000 periodly. Prefetch is a new and very useful technique in Windows XP. However, after using XP some time, the prefetch directory can get full of junk and obsolete links in the Prefetch catalog, which can slow down your computer notablely. My suggestion is: open C(system drive):/windows/prefetch, delete those junk and obsolete files,reboot. It is recommended that you do this every month. 

<strong>Remove hibernation file</strong>
If you do not use hibernation, make sure you do not have it enabled, which reserves disk space equal to your RAM. If you have a hidden file on the root directory of your C-drive called hiberfil.sys, hibernation is enabled. To remove that file, go to Control Panel, select Performance and Maintenance, Power Options, Hibernate tab, and uncheck the Enable hibernation box.

<strong>Improve NTFS Performance</strong>
The NTFS file system is the recommended file system because of its advantages in terms of reliability and security and because it is required for large drive sizes. However, these advantages come with some overhead. You can modify some functionality to improve NTFS performance as follows:

1. Disable creation of short names. By default, NTFS generates the style of file name that consists of eight characters, followed by a period and a three-character extension for compatibility with MS-DOS and MicrosoftÂ® WindowsÂ® 3.x clients. If you are not supporting these types of clients, you can turn off this setting by changing the default value of the NtfsDisable8dot3NameCreation registry entry (in HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Filesystem) to 1. 

2. Disable last access update. By default NTFS updates the date and time stamp of the last access on directories whenever it traverses the directory. For a large NTFS volume, this update process can slow performance. To disable automatic updating, change the value of the NtfsDisableLastAccessUpdate registry entry (in HKEY_LOCAL_MACHINE\SYSTEM\CurrentContolSet\Control\Filesystem) to 1. If the entry is not already present in the registry, add it before setting the value. (Add it as a REG_DWORD) 

3. Reserve appropriate space for the master file table. Add the NtfsMftZoneReservation entry to the registry as a REG_DWORD in HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem. When you add this entry to the registry, the system reserves space on the volume for the master file table. Reserving space in this manner allows the master file table to grow optimally. If your NTFS volumes generally contain relatively few files that are typically large, set value of this registry entry to 1 (the default). Typically you can use a value of 2 or 3 for moderate numbers of files, and 4 (the maximum) if your volumes tend to contain a relatively large number of files. However, be sure to test any settings greater than 2 because these higher values cause the system to reserve a much larger portion of the disk for the master file table. 

Reboot after making changes

<strong>Unload .dll''s to Free Memory</strong>
Windows Explorer caches DLLs (Dynamic-Link Libraries) in memory for a period of time after the application using them has been closed. This can be an inefficient use of memory. 

1. Find the key [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]. 
2. Create a new DWORD sub-key named ''AlwaysUnloadDLL'' and set the default value to equal ''1'' to disable Windows caching the DLL in memory. 
3. Restart Windows for the change to take effect. 

I tried this after running a intense program, then watched the task manager; memory recovered it self. 

<strong>Remove start-up items</strong>
Having programs run when windows loads slows down your start.

There are two ways do disable programs that may be in your startup (like icq, messanger,)

The easiest is to do the following:
1. start --&gt; run --&gt; msconfig
2. Click on the "startup" tab (furthest right)\
3. Unclick any items you don''t want to load when windows starts.

The second is by deleting registry entrys, this can be done the following way:
1. Start --&gt; run --&gt; regedit
2. Navigate to : \HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
3. Delete any entry''s that you don''t want to load up

***NOTE***
Deleting keys from the registry will not allow you to set them to startup again if you change your mind. 
**********

<strong>Reduce 10 second scandisk wait time</strong>
Start MS Dos Prompt (Start run CMD)
CHKNTFS/T:4
where 4 is the amount of waity time

CHKNTFS/? 
for more info

<strong>System Page Memory Tweak</strong>
Hi, I''m not 100% sure if this tweak will yield a great performance boost to the majority of users out there, but for me it seems to have shown very good results. By default, if you look in the [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management]key, you''ll see the ''SystemPages'' DWORD Value set to something around 500 MB (more accurately, 524288 (KB), or something close to that value). Simply reduce the value to something around 128 MB (131072 KB) or 256 MB (262144 KB). Personally, I''m using the 128 MB setting, since my total RAM is 256 MB. It might help to experiment a little, since each machine will most likely yield better or worse results. Good Luck!

<strong>Get rid of IM and no slow OE startup</strong>
If you have OE 6 got to tools &gt; windows messenger &gt; options &gt; preferences and in the general area uncheck "run this program when windows starts" and "allow this program to run in the background." After doing this IM does not load on startup and OE loads as usual.
Hope it helps.

<strong>Convert FAT32 To NTFS</strong>
To change from FAT 32 to NTFS for more stability and security, open the command prompt and type: "Convert C: /FS:NTFS". Make sure there is a space between the C: and the foward slash (/). Once you press enter it will ask you for confirmation and press Y. Then press Y and enter once more to reboot. It will take between one hour and 15 minutes to convert to NTFS. Now you can set passwords for files and use encryption. This also works for windows XP Home.

<strong>Fix for slow loading of Outlook Express when Messenger is disabled</strong>
Open up Register Editor by running "regedit" command. Click on "Edit" and select "Find". Copy and paste FB7199AB-79BF-11D2-8D94-0000F875C541 onto the "Find what" box and click on "Find Next". Once found, click on the plus sign in front of it and you will find InProc32 and LocalServer32. Select one of them then right click on default under the name column and select "modify", then simply delete what''s in the Value Data box. Repeat for the other.

<strong>Virtual Paging File</strong>
This tweak can increase the amount of RAM significantly used on your computer. What this tweak actually does is it uses your hard-drive disk-space to emulate RAM. This is called caching, or in Microsoft terms - The Virtual Paging File Size.

1.) Go into Control Panel and into Performance and Maintenance
2.) Get into System
3.) Click the Advanced Tab
4.) In the Performance Frame, click on Settings
5.) Once in Settings click on the Advanced Tab
6.) Now under Virutal Memory click on Change
7.) Here you can set your RAM value. The recommended increase you should make should be achieved by multiplying your RAM by 1.5. This is already done if you have a System Managed file size. I like to increase it by 1/5 of my actual hard-drive space. This will drastically increase performance, because the system will now have a pool of cache to retrieve memory from. 


<strong>DMA Mode on IDE Devices</strong>
Just like Windows 2000, Windows XP still fails to set the DMA mode correctly for the IDE device designated as the slaves on the primary IDE and secondary IDE channels. Most CD-ROMS are capable of supporting DMA mode, but the default in XP is still PIO. Setting it to DMA won''t make your CD-ROM faster, but it will consume less CPU cycles. Here''s how:

1. Open the Device Manager. One way to do that is to right click on "My Computer", select the Hardware tab, and Select Device Manager.
2. Expand "IDE ATA/ATAPI Controllers" and double-click on "Primary IDE Channel"
3. Under the "Advanced Settings" tab, check the "Device 1" setting. More than likely, your current transfer mode is set to PIO.
4. Set it to "DMA if available".

Repeat the step for the "Secondary IDE Channel" if you have devices attached to it. Reboot.

<strong>Speed up Network Browsing</strong>
There was a bug in windows 2000 that would cause the scheduled tasks folder to be searched when ever the user would browse network drives. Microsoft developed a fix for this bug. The fix fixed the problem and it also had nice side affect of speeding up browsing of Microsoft networks. Below are instructions how to apply the fix.

1. Open up regedit. 
2. Navigate to HKEY_LOCAL_MACHINE/Software/Microsoft/Windows/Current Version/Explorer/RemoteComputer/NameSpace. 
3. Find a key named {D6277990-4C6A-11CF-8D87-00AA0060F5BF}. 
4. Right click on it and delete it. 
5. Restart 

<strong>Speed up menu display</strong>
When using the start menu the you will notice a delay between different tiers of the menu hierarchy.  For the fastest computer experience possible I recommend changing this value to zero.  This will allow the different tiers to appear instantly.
1.	Start Regedit.  If you are unfamiliar with regedit please refer to our FAQ on how to get started. 
2.	Navigate to HKEY_CURRENT_USER\Control Panel\Desktop 
3.	Select MenuShowDelay from the list on the right. 
4.	Right on it and select Modify. 
5.	Change the value to 0. 
6.	Reboot your computer. 

<strong>Uninstall Msn Messenger - batch script</strong>
Here is how to uninstall msn messenger from you XP system :-) 

1. copy this code into your text document and save it with extension "bat" without quotes

@echo off
echo Removing Microsoft Messenger...
rundll32 advpack.dll,LaunchINFSection %WinDir%\inf\msmsgs.inf,BLC.Remove

echo Disabling it from running in the future...
echo REGEDIT4&gt;%temp%\nomsngr.reg
echo
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Messenger\Client]&gt;&gt;%temp%\no
msngr.reg
echo "PreventRun"=dword:00000001&gt;&gt;%temp%\nomsngr.reg
echo "PreventAutoRun"=dword:00000001&gt;&gt;%temp%\nomsngr.reg
echo "PreventAutoUpdate"=dword:00000001&gt;&gt;%temp%\nomsngr.reg
echo "PreventBackgroundDownload"=dword:00000001&gt;&gt;%temp%\nomsngr.reg
echo "Disabled"=dword:00000001&gt;&gt;%temp%\nomsngr.reg
regedit /s %temp%\nomsngr.reg


2. double click on it and restart computer
3. msn messenger will be uninstalled from you system

<strong>Remove history in internet explorer address bar</strong>
Internet Explorer keeps track of each URL that you type in the address bar as a convenience to save you from typing the next time that you visit that site.  However, any user that uses your computer can find out what addresses you typed in as well so some may be interested in clearing the address bar addresses.  Just clearing the browser history will not do this as a registry modification is needed:
1.	Click on Start, then Run. 
2.	Type regedit in the box provided. 
3.	In Regedit navigate to HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Typed URLs 
4.	Then just delete all of the keys that list the URL''s you no longer want to see.

<strong>Fix for slow xDSL Internet access</strong>
This tweak is also valid for all Windows versions.
Sometimes during browsiing you can notice that it takes time to access any web page, and then, suddenly, your connection establishes full-speed again. The reason lays in amount of time it needs for tcp/ip protocol to translate a host name to an IP address. In order to fix this problem your xDSL modem shoud have an internal IP address specified in TCP/IP properties. For Win98 it would be TCP/IP bounded to NIC. 
In most of the cases IP address would be 192.168.1.2; subnet mask : 255.255.255.0.

Hope it helps.

<strong>Speeding up Share Viewing</strong>
When you connect to another computer with Windows XP, it checks for any Scheduled tasks on that computer - a fairly useless task, but one that can add up to 30 seconds of waiting on the other end - not good! Fortunately, itâ??s fairly easy to disable this process.

First, navigate to HKEY_LOCAL_MACHINE/Software/Microsoft/Windows/Current Version/Explorer/RemoteComputer/NameSpace
in the Registry. Below that, there should be a key called {D6277990-4C6A-11CF-8D87-00AA0060F5BF}. Just delete this, and after a restart, Windows will no longer check for scheduled tasks - major performance improvement!

<strong>Load Internet Explorer the fastest way possible</strong>
Edit your link to start Internet Explorer to have -nohome after it. For Example: "C:\Program Files\Internet Explorer\IEXPLORE.EXE" -nohome
This will load internet explorer very fast because it does not load a webpage while it is loading. If you want to go to your homepage after it is loaded, just click on the home button.

<strong>Speed up browsing with DNS catch</strong>
When you connect to a web site your computer sends information back and forth, this is obvious. Some of this information deals with resolving the site name to an IP address, the stuff that tcp/ip really deals with, not words. This is DNS information and is used so that you will not need to ask for the site location each and every time you visit the site. Although WinXP and win2000 has a pretty efficient DNS cache, you can increase its overall performance by increasing its size. 

You can do this with the registry entries below: 

************begin copy and paste*********** 
Windows Registry Editor Version 5.00 

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters] 
"CacheHashTableBucketSize"=dword:00000001 
"CacheHashTableSize"=dword:00000180 
"MaxCacheEntryTtlLimit"=dword:0000fa00 
"MaxSOACacheEntryTtlLimit"=dword:0000012d 

************end copy and paste*********** 

Make a new text file and rename it to dnscache.reg. The copy and paste the above into it and save it. Then merge it into the registry

<strong>Disable ICMP Redirect for security</strong>
If your running server versions, add the following reg_dword in the location shown and set it to "0". This will help keep an icmp re-direct attack from taking over your server. 

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters] 
"EnableICMPRedirect"=dword:00000000 

Works in both Win2k and XP', 'IT Tips', '["IT Tips"]', '31 min read', 'published', '2005-11-30 15:14:11');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Tech jargon', 'tech-jargon', 'Virus - Malicious program designed to damage data; usually spread via infected e-mail attachments Trojan - Malicious software disguised as harmless program Firewall - Software to…', '<strong>Virus</strong> - Malicious program designed to damage data; usually spread via infected e-mail attachments
<strong>Trojan</strong> - Malicious software disguised as harmless program
<strong>Firewall</strong> - Software to protect computers against hackers
<strong>Keylogging</strong> - Software/hardware to track keystrokes on a computer to gather passwords, credit card numbers
<strong>Pharming</strong> - When fraudsters redirect net users from legitimate to fake sites
<strong>Phishing</strong> - Fraudulent e-mails and pop-ups to fool you into revealing personal information for criminal gain
<strong>Rogue dialler</strong> - Software that installs itself on computers and changes settings to dial a premium rate number instead of usual dial-up account
<strong>Spam</strong> - Unsolicited e-mails, often offering products or services in which you have no interest 
<strong>Spyware</strong> - Small programs that secretly monitor sites visited, potentially violating privacy and slowing computers', 'Interesting', '["IT Tips"]', '1 min read', 'published', '2005-11-30 14:32:03');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Remove duplicates in MS Outlook', 'remove-duplicates-in-ms-outlook', 'When you import items into Microsoft Outlook and you add the contact as a duplicate, or if duplicate detection is turned off, there is not an option to remove duplicate items…', 'When you import items into Microsoft Outlook and you add the contact as a duplicate, or if duplicate detection is turned off, there is not an option to remove duplicate items after you import. This article explains one method to delete duplicate items after you complete the import process. 

<strong>How to Delete Duplicate Items</strong>

Use the following steps to duplicate items: 

1.	On the View menu, point to Current View, and then click to change the folder view to a table type view. For example, use the following view and field combinations:
2.	View	Field     Calendar	Active     Appointments     Contacts	Phone List Inbox	Messages Journal	Entry List           Notes	Notes List
3.	Right-click a column heading, and then click Field Chooser. 
4.	From the list at the top of the Field Chooser, click to select the All  fields. 
5.	Drag the Modified field to the table heading. 
6.	Verify that the duplicate items have a unique date from the original set of items. If it is unique, click the Modified heading so that the items are sorted by this field. 
7.	Click the first item in the set that you want to delete, scroll to the last item in the set that you want to delete, and then click the last item while you hold down the SHIFT key. 
8.	Press DELETE to permanently delete all selected items.', 'IT Tips', '["IT Tips"]', '1 min read', 'published', '2005-11-30 14:28:14');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Google tips you can use', 'google-tips', 'Use Quotation Marks This is our nominee for all-time most useful hint. Search for Tiger Woods, and Google will give you about 450,000 results. Yikes. Search for "Tiger Woods" in…', '<strong>Use Quotation Marks</strong>
This is our nominee for all-time most useful hint. Search for Tiger Woods, and Google will give you about 450,000 results. Yikes. Search for "Tiger Woods" in quotation marks, you''ll get 342,000 results. That''s still too many (keep reading!), but at least none will relate to animals or forests. When you know the exact name or phrase you''re looking for, quotation marks can only help.

<strong>Learn the Three Fundamentals</strong>
Google doesn''t drag you down with complicated search strings and dreaded Boolean operators. Just remember these three things. Use a plus sign in your search request only when an everyday word is crucial to the search (Godfather +I). And use a minus sign if you want to exclude certain terms from a search. A search for bass -fish will steer you away from the water and toward the world of music. (Be sure to leave a space before those plus or minus signs, but not after them.) Focused results are the goal.

<strong>Search by Category</strong>
Many Googlers don''t realize that in addition to its search box, Google has its own simple Web directory. Click the Directory tab on Google''s home page to bring it up, and then start drilling down through the categories that interest you. It''s basicâ??not comprehensive, the way Yahoo!''s isâ??and useful when you''re just starting your research.

<strong>Search Related Sites</strong>
You''ve finally found the exact kind of site you were looking for. Congratulations, but don''t stop now. Use the "related" command, coupled with the URL, to find more sites like it (related:www.tigerwoods.com returns 23 excellent sites about golf).

<strong>Search From the Inside Out</strong>
If you''ve found a site you need, chances are that some of the sites that link to it will also be useful to you. Enter link:www.tigerwoods.com , for example, and you''ll get back 954 sites. (You can also use this technique to find out who, if anyone, is linking to your own personal site.)

<strong>Indulge Your Obsessive Streak</strong>
If you can''t bear to miss out on a single Tiger Woods site, enter allinurl:tigerwoods to get a list of all the sites with "tigerwoods" in their URL. Instead of getting thousands of pages that mention Tiger somewhere in them, you''ll get only those sites that actually feature the word in their Web address. The result: a more targeted searchâ??in this case, a relatively manageable 1,460 results to look through.

<strong>Search Within a Particular Site</strong>
For fine-tuned research, you can limit your search to a single Web site. Want all the information about Tiger Woods featured at the site of his alma mater, Stanford? Enter tiger woods site:www.stanford.edu and get just 63 resultsâ??a nice, tight search. Another example: valve site:www.americanheart.org, for 101 entries about heart valve problems from the American Heart Association.

<strong>Bring Sites Back From the Dead</strong>
It''s a fact of Net life: Sites die. But if your dream page turns up a 404 (i.e., dead-link notice), hit the Back button and play mad scientist. Look for the Cached link at the end of the Google description. That''s a link to the backup version Google keeps of all the pages it indexes. A simple click displays its stored version. Bear in mind, though, that the page will only be current as of the day Google indexed it.

<strong>Search for Images</strong>
Want to find photos of Tiger Woods but don''t want to sift through thousands of sites to find the ones with pics? Click the Images tab on Google''s home page and type in "Tiger Woods" (with the quotes) to get hundreds of swingin'' shots. Click on any one to find out more about it, to see a larger version, or to visit the site on which it was found.

<strong>Scour the Newsgroups</strong>
Long before the World Wide Web emerged, the Internet was crowded with Usenet newsgroups, in which discussions on every imaginable topic took place. They''re still out there today, and Google will search a 20-year archive of 700 million newsgroup messages for you. Just click on the Groups tab on Google''s home page. Be warned: Newsgroups can be huge and weird, so searching them can be a real time-waster unless you''re passionately interested in your search topic. For basic, top-level searches, don''t bother.

<strong>Google Last Night''s Date (Or Prepare for Tonight''s)</strong>
If you went on a first date with "John Smith" or "Mary Jones" last night, Google won''t be much help in digging up the dirt unless you give it more to go on. Put the name in quotation marks and follow it with as many specifics relating to the person that you can think of. His company. Her hometown. His college. Her profession. Keep at it, and eventually you''ll get some details about your specific John or Mary. Was your date Tiger Woods? If so, just skip the research and accept that second date.

<strong>And While You''re at It, Google Yourself</strong>
Here''s a great way to do a quick security check on your online identity. Search for your own name, of course, but also search for various permutations of your address. And try Googling your credit card numbers. If any of these things are popping up in weird places, take action.

<strong>Use Google as a Phone Book and Atlas</strong>
Enter a first and last name and a city and state to get the address and phone number of anyone listed in the phone book (for the record, we couldn''t find Tiger). You can also enter a phone number to find the related address and generate a map from Yahoo! Maps or MapQuest. Another feature: Enter a street address, city, and state to get a map of the area. Or enter the name of a business and its ZIP code to get its phone number, address, and Web site, as well as a neighborhood map.

<strong>Toss Your Dictionary in the Trash</strong>
Whenever your search includes a word that''s listed in a dictionary, Google underlines the word in its results page above the list of links offered. Click on that word and you''ll get not only definitions but also spelling corrections as necessary.

<strong>Don''t Sweat Your Near Misses</strong>
Speaking of corrections, if you misspell your search term, Google will dutifully perform a search on your cracked lexicography, but if possible it will also suggest a more popular version. Thus, the first link for your search on Tigger Woods will be Did you mean: Tiger Woods? And you''ll click on that, unless, of course, you''re a closet Winnie-the-Pooh fan.
<strong>
Narrow Your Search by File Type </strong>
Typically when you search the Web for information you expect to pull up traditional Web pages in the form of HTML files. Google offers results in a variety of different formats, however, including .PDF (Adobe Portable Document Format), .DOC (Microsoft Word), .PS (Adobe Postscript), and .XLS (Microsoft Excel). These files appear among your regular search results listings where you can either view them in their original format, or use the View as HTML link (good for when you don''t have the application that is needed for that particular file type, or for when computer viruses are a concern). You can also use the filetype command to narrow your search to find documents in particular formats (i.e. filetype:xls genealogy forms). You aren''t likely to use this Google feature often, but I have used it to find genealogy brochures in PDF format and family group sheets and other genealogy forms in Microsoft Excel format.

<strong>Visit the Preferences Page</strong>
Google: Preferences lets you set languages, the number of results you''d like to see per page, the level of family-friendly filtering you''d like to set, and more. They''re great tools for turning Google into Your Personal Google.

<strong>Googlize Your Browser</strong>
Want to make Google searching a regular habit? If you use Internet Explorer 5.0 or later, download the free Google Toolbar to put Google and some of its most important features right on your browser screen at all times. If you search several times a day, it''ll save you lots of clicks.

<strong>Giggle With Google</strong>
Go to [google.com/language_tools], and you''ll see a menu of 73 languages into which you can translate the Google interface. Wunderbar! But look at that list again. See anything unusual? Among your language choices are "Bork, bork, bork!" "Elmer Fudd," and "Hacker." As Elmer might say, "I''m Feewing Wucky," or as a Klingon would growl, "jlDo''." And by the way, if you''ve ever wondered where Google''s entertaining holiday logos come from, stop by the gallery and have a look at the handiwork of 23-year-old programmer Dennis Hwang. Who knows what he''ll come up with for Monet''s birthday this year?', 'Google', '["IT Tips"]', '8 min read', 'published', '2005-11-30 14:20:54');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('The Ten Immutable Laws of Security', 'the-ten-immutable-laws-of-security', '1. If a bad guy can persuade you to run his program on your computer, it is not your computer anymore. 2. If a bad guy can alter the operating system on your computer, it is not…', '1.	If a bad guy can persuade you to run his program on your computer, it is not your computer anymore.
2.	If a bad guy can alter the operating system on your computer, it is not your computer anymore.
3.	If a bad guy has unrestricted physical access to your computer, it is not your computer anymore.
4.	If you allow a bad guy to upload programs to your web site, it is not your web site any more.
5.	Weak passwords trump strong security. 
6.	A machine is only as secure as the administrator is trustworthy.
7.	Encrypted data is only as secure as the decryption key.
8.	An out of date virus scanner is only marginally better than no virus scanner at all.
9.	Absolute anonymity isn''t practical, in real life or on the web.
10.	Technology is not a panacea.', 'Security', '[]', '1 min read', 'published', '2005-11-30 14:13:58');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Good managers best skills', 'good-manager', '"Your job as a manager for your employees is to assign them the work to do, see they do it satisfactorily, take the blame FOR them if they screw up, and then tell them to stop…', '"Your job as a manager for your employees is to assign them the work to do, see they do it satisfactorily, take the blame FOR them if they screw up, and then tell them to stop messing up in PRIVATE. And when time comes, you fight tooth and nail to get every penny you can out of the higher ups to make sure they get the best raises they can get."', 'Career Tips', '[]', '1 min read', 'published', '2005-11-30 14:07:26');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('Presentation tips you need to know', 'presentation-tips', 'Vocal Advantage: What matters is how you say it. Research has shown that face-to-face communication is: 55% visual 38% tone of the voice 7% content* Successful communication, in a…', '<strong>Vocal Advantage:</strong>

What matters is how you say it.
Research has shown that face-to-face communication is: 

<ol>
	<li>55% visual </li>
	<li>38% tone of the voice </li>
	<li>7% content*</li>
</ol>

Successful communication, in a speech or one-on-one, is a conversation.
In addition to their voices, presenters speak with their eyes and their body language. The listeners will speak loudly in the same way. As presenters, we need to have an eye-to-eye conversation with each individual.

<strong>Presentation Tips:</strong>

<ul>
	<li>Speak out! Volume and clarity always.</li>
	<li>Get the listeners attention right away. Once you lose them, you will never get them back.</li>
	<li>Prepare, prepare and prepare some more. Your nerves will reduce significantly. It is best if you can rehearse in the room where you will be presenting.</li>
	<li>Direct your eyes. Speak with your eyes. Find the eyes of the listeners as you speak and stay with them until you finish a sentence.</li>
	<li>Look sharp. According to research, 55% of all communication is done visually. You are the most important visual aid in the presentation.</li>
	<li>Let your hands relax at your sides at the beginning. Make gestures that are natural and connected to your message.</li>
	<li>Keep the "hand outs" as an optional "take with you" gift. There is no need for them to duplicate the PowerPoint slides. Keep their eyes on YOU!</li>
	<li>Use silence. There is no need to fill every moment with sound. Pauses are effective for emphasis and for poise.</li>
	<li>Repeat or rephrase the question. That will ensure that you understand it properly, the others hear it clearly and it gives you a moment to form your answer.</li>
	<li>Close, after the questions, with a specific call to action. </li>

*Dr. Albert Mehrabian of UCLA', 'Career Tips', '["Presentation"]', '1 min read', 'published', '2005-11-30 14:04:16');
INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('How good is del.icio.us?', 'how-good-is-delicious', 'del.icio.us will save your bookmarks on web so that they are accessible from anywhere. Organization is possible by tags, alphabetically or frequency. Saved bookmarks can be shared…', '<a href="http://www.delicious.com">del.icio.us</a> will save your bookmarks on web so that they are accessible from anywhere. Organization is possible by tags, alphabetically or frequency. Saved bookmarks can be shared with other users of del.icio.us by using provided post/for inbox features.

Highly recommended.', 'Web 2.0', '["Web 2.0"]', '1 min read', 'published', '2005-11-29 19:30:26');