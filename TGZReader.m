classdef TGZReader < handle
    % by Morgan R. Frank (8/21/13)
    % TGZReader.m is an object designed to read from .gz and .tgz files
    % line by line without having to unzip the files. The JVM must be
    % active to use this object.
    % Example:
    %   tgz=TGZReader('/Users/admin/Documents/MITRE/27.04.13.tgz');
    %   for i=1:5;disp(tgz.readLine());end;
    %
    %   27.04.13/
    %
    %   {"created_at":"Sat Apr 27 17:45:00 +0000 2013","id":328203138857332737,"id_str":"328203138857332737","text":"Haters gonna hate, duck is going duck, quack, quack . \n-Pewds http:\/\/t.co\/FKZDdGGkpd","source":"\u003ca href=\"http:\/\/twitter.com\/download\/iphone\" rel=\"nofollow\"\u003eTwitter for iPhone\u003c\/a\u003e","truncated":false,"in_reply_to_status_id":null,"in_reply_to_status_id_str":null,"in_reply_to_user_id":null,"in_reply_to_user_id_str":null,"in_reply_to_screen_name":null,"user":{"id":1260448548,"id_str":"1260448548","name":"LV","screen_name":"LoranskyKat","location":"Kyiv,Ukraine. ","url":null,"description":"Hi. My name is Kate, I'm ukranian girl. I love figure skating. My life is a lot of fun, and I totally love that.","protected":false,"followers_count":20,"friends_count":32,"listed_count":0,"created_at":"Mon Mar 11 21:33:31 +0000 2013","favourites_count":32,"utc_offset":10800,"time_zone":"Baghdad","geo_enabled":false,"verified":false,"statuses_count":175,"lang":"ru","contributors_enabled":false,"is_translator":false,"profile_background_color":"C0DEED","profile_background_image_url":"http:\/\/a0.twimg.com\/images\/themes\/theme1\/bg.png","profile_background_image_url_https":"https:\/\/si0.twimg.com\/images\/themes\/theme1\/bg.png","profile_background_tile":false,"profile_image_url":"http:\/\/a0.twimg.com\/profile_images\/3581627894\/b8fc0b205a8451f3311679abbce07ff3_normal.jpeg","profile_image_url_https":"https:\/\/si0.twimg.com\/profile_images\/3581627894\/b8fc0b205a8451f3311679abbce07ff3_normal.jpeg","profile_banner_url":"https:\/\/si0.twimg.com\/profile_banners\/1260448548\/1366656084","profile_link_color":"0084B4","profile_sidebar_border_color":"C0DEED","profile_sidebar_fill_color":"DDEEF6","profile_text_color":"333333","profile_use_background_image":true,"default_profile":true,"default_profile_image":false,"following":null,"follow_request_sent":null,"notifications":null},"geo":null,"coordinates":null,"place":null,"contributors":null,"retweet_count":0,"favorite_count":0,"entities":{"hashtags":[],"symbols":[],"urls":[],"user_mentions":[],"media":[{"id":328203138861527041,"id_str":"328203138861527041","indices":[62,84],"media_url":"http:\/\/pbs.twimg.com\/media\/BI4DBBICcAEybKR.jpg","media_url_https":"https:\/\/pbs.twimg.com\/media\/BI4DBBICcAEybKR.jpg","url":"http:\/\/t.co\/FKZDdGGkpd","display_url":"pic.twitter.com\/FKZDdGGkpd","expanded_url":"http:\/\/twitter.com\/LoranskyKat\/status\/328203138857332737\/photo\/1","type":"photo","sizes":{"medium":{"w":600,"h":800,"resize":"fit"},"large":{"w":768,"h":1024,"resize":"fit"},"small":{"w":340,"h":453,"resize":"fit"},"thumb":{"w":150,"h":150,"resize":"crop"}}}]},"favorited":false,"retweeted":false,"possibly_sensitive":false,"filter_level":"medium","lang":"en"}
    %
    %   {"delete":{"status":{"id":327830764395851777,"user_id":1379750928,"id_str":"327830764395851777","user_id_str":"1379750928"}}}
    %
    %   {"delete":{"status":{"id":290921023530995714,"user_id":790533686,"id_str":"290921023530995714","user_id_str":"790533686"}}}
    %
    %   {"delete":{"status":{"id":257858046477348864,"user_id":712968480,"id_str":"257858046477348864","user_id_str":"712968480"}}}
    %
    % Properties:
    %   file=Java File object indicating the file being read from or NaN if
    %       no file is specified.
    %   lineCount =  a number indicating how many lines have been read from
    %       the most recently opened file. 
    %   fileName = string representing the absolute path to the most
    %       recently opened file. NaN if no files have been opened.
    %   FIS =  Java FileInputStream object
    %   GIS = Java GZIPInputStream object
    %   ISR = Java InputStreamReader object
    %   BR =  Java BufferedReader object
    %   line = a char representing the most recently read line or NaN is no
    %       lines have been read.
    %
    % Methods:
    %   TGZReader(name) is the constructor. name is an optional parameter
    %       will allow TGZReader to initialize with an open file for
    %       reading.
    %   setFile(obj,name) = obj represents an instance of TGZReader.
    %                       name is a string representing the path to a
    %                       file to be read from. This method will close an
    %                       open file and instead open the new file.
    %   getFile(obj) = string representing the absolute path to the most
    %       recently opened file. NaN if no files have been opened.
    %   getLineCount(obj) = returns a number representing the number of
    %       lines that were read from the most recently opened file. NaN if
    %       no files have been opened.
    %   readLine(obj) = returns the next line in an opened file. Throws an
    %       error if no file is opened.
    %   close(obj) closes all connections to the currently opened file.
   properties
       file;
       fileName;
       lineCount;
       FIS;
       GIS;
       ISR;
       BR;
       line;
   end;
   properties(Hidden)
       isOpen;
   end;
   methods
       function obj=TGZReader(name)
           % tgz=TGZReader(name)
           % Input:
           %    name is an optional parameter if you wish to initialize
           %    TGZReader with an open file.
           if ~usejava('jvm')
               error('TGZReader requires an active JVM');
           end;
           obj.line=NaN;
           obj.fileName=NaN;
           obj.isOpen=false;
           if nargin==1
               obj.openFile(name);
               obj.lineCount=0;
           elseif nargin==0
               obj.file=NaN;
               obj.lineCount=NaN;
           else
               error('Incorrect inputs for TGZReader.');
           end;
       end;
       
       function setFile(obj,name)
           obj.close();
           obj.openFile(name);
           obj.lineCount=0;
       end;
       
       function name=getFile(obj)
           name=obj.fileName;
       end;
       
       function count=getLineCount(obj)
           count=obj.lineCount;
       end;
       
       function L=readLine(obj)
           if ~obj.isOpen
               error('No File has been initialized.');
           end;
           obj.line=obj.BR.readLine();
           L=char(obj.line);
           obj.lineCount=obj.lineCount+1;
       end;
       
       function close(obj)
           if obj.isOpen
               obj.BR.close();
               obj.ISR.close();
               obj.GIS.close();
               obj.FIS.close();
               obj.file=NaN;
           end;
           obj.isOpen=false;
       end;
   end;
   methods(Hidden)
       function openFile(obj,name)
           import java.lang.*;
           import java.util.*;
           import java.util.zip.*;
           import java.io.*;
           obj.file=File(name);
           obj.fileName=obj.file.getAbsolutePath();
           obj.FIS=FileInputStream(obj.file);
           obj.GIS=GZIPInputStream(obj.FIS);
           obj.ISR=InputStreamReader(obj.GIS);
           obj.BR=BufferedReader(obj.ISR);
           obj.isOpen=true;
       end;
   end;
end