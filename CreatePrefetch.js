"// comments\n<br/>\nprefetch " +
$('#basic-info > div > div > table > tbody > tr:has(> td:contains("File name:") ) > td:nth-child(2)').text().trim() +
" sha1:" + 
$('div#file-details.extra-info').children('div').children('div:has(> span:contains("SHA1") )').contents().filter(function() { return this.nodeType == 3; }).text().trim() +
" size:" +
$('div#file-details.extra-info').children('div').children('div:has(> span:contains("File size") )').contents().filter(function() { return this.nodeType == 3; }).text().split(' ( ')[1].split(' bytes ')[0] +
" http://PUT_URL_TO_FILE_HERE sha256:" +
$('div#file-details.extra-info').children('div').children('div:has(> span:contains("SHA256") )').contents().filter(function() { return this.nodeType == 3; }).text().trim();