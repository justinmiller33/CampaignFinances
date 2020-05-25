%completeDistributionAnalysis
%Sourced from distributionAnalysis but for all representatives for comp.

load('senators.mat');
load('donations.mat');
load("C:\devel\CampaignFinances\2018 Elections Only\2018Donations.mat");

donations = senate2018;
%List of Reps
reps = ["Feeney, Paul","Barrett, Michael J.","Boncore, Joseph Angelo","Brady, Michael D.","Chandler, Harriette L.","Finegold, Barry R.","Comerford, Joanne","Cyr, Julian Andre","Eldridge, James","Fattman, Ryan","Gobi, Anne M.","Hinds, Adam Gray","Keenan, John F.","Kennedy, Edward","Lesser, Eric Phillip","Lewis, Jason","Lovely, Joan","Moore, Michael","O'Connor, Patrick Michael","Pacheco, Marc R.","Rausch, Rebecca Lynne","Rodrigues, Michael J.","Rush, Michael F.","Spilka, Karen","Timilty, Walter F.","Tran, Dean A.","Welch, James T."];

%Parallel list of distNums
distNums = [32,6,1,34,7,14,38,26,11,9,24,37,2,10,39,17,16,8,33,21,13,35,31,12,20,0,19];

%Parallel list of towns completely covered
townsC = cell(length(reps),1);
townsC{1} = ["Mansfield","Norton","Seekonk","Rehoboth","Foxborough","Medfield","Sharon","Foxboro"];
townsC{2} = ["Waltham","Bedford","Carlisle","Chelmsford","Concord","Lincoln","Weston"];
townsC{3} = ["Revere","Winthrop"];
townsC{4} = ["Brockton","Halifax","Hanover","Hampton","Plympton","Whitman"];
townsC{5} = ["Boylston","Holden","Princeton","West Boylston"];
townsC{6} = ["Lawrence","Andover","Tewksbury","Dracut"];
townsC{7} = ["Northampton","Amherst","Hadley","Hatfield","Pelham","South Hadley","Bernardston","Colrain","Deerfield","Erving","Gill","Greenfield","Leverett","Leyden","Montague","New Salem","Northfield","Orange","Shutesbury","Warwick","Sunderland","Wendell","Whately","Royalston"];
townsC{8} = ["Barnstable","Brewster","Chatham","Dennis","Eastham","Harwich","Mashpee","Orleans","Provincetown","Truro","Wellfleet","Yarmouth","Aquinnah","Chilmark","Edgartown","Gosnold","Oak Bluffs","Tissbury","West Tisbury","Nantucket"];
townsC{9} = ["Marlborough","Acton","Ayer","Boxborough","Hudson","Littleton","Maynard","Shirley","Stow","Harvard","Southborough","Westborough"];
townsC{10} = ["Blackston","Douglas","Dudley","Hopedale","Mendon","Milford","Millville","Oxford","Southbridge","Sutton","Uxbridge","Bellingham"];
townsC{11} = ["Ashburnham","Athol","Barre","Brookfield","Charlton","East Brookfield","Hardwick","Hubbardston","New Braintree","North Brookfield","Oakham","Paxton","Petersham","Phillipston","Rutland","Spencer","Sturbridge","Templeton","Warren","West Brookfield","Winchendon","Brimfield","Holland","Monson","Palmer","Wales","Ware","Ashby"];
townsC{12} = ["Adams","Berkshire","Alford","Ashfield","Becket","Buckland","Blandford","Buckland","Charlemont","Cheshire","Chester","Chesterfield","Clarksburg","Conway","Cummington","Dalton","Egremont","Florida","Goshen","Great Barrington","Hancock","Hawley","Heath","Hinsdale","Huntington","Lanesborough","Lee","Lenox","Middlefield","Monroe","Monterey","Mount Washington","New Ashford","New Marlborough","Otis","Peru","Plainfield","Richmond","Rowe","Sandisfield","Savoy","Sheffield","Shelburne","Stockbridge","Tyringham","Washington","West Stockbridge","Westhampton","Williamsburg","Williamstown","Windsor","Worthington","North Adams"];
townsC{13} = ["Quincy","Holbrook","Abington","Rockland"];
townsC{14} = ["Lowell","Dunstable","Groton","Pepperell","Tyngsborough","Westford","Tyngsboro"];
townsC{15} = ["East Longmeadow","Hampden","Longmeadow","Ludlow","Wilbraham","Belchertown","Granby"];
townsC{16} = ["Malden","Melrose","Reading","Stoneham","Wakefield"];
townsC{17} = ["Beverly","Peabody","Salem","Danvers","Topsfield"];
townsC{18} = ["Auburn","Grafton","Leicester","Shrewsbury","Upton"];
townsC{19} = ["Duxbury","Hingham","Hull","Marshfield","Norwell","Scituate","Cohasset","Weymouth"];
townsC{20} = ["Bridgewater","Carver","Marion","Middleborough","Middleboro","Wareham","Berkley","Raynham","Taunton"];
townsC{21} = ["Millis","Norfolk","Plainville","Wrentham","North Attleboro","North Attleborough","Sherborn","Wayland"];
townsC{22} = ["Fall River","Freemont","Somerset","Swansea","Westport","Lakeville","Rochester"];
townsC{23} = ["Dover","Dedham","Needham","Norwood","Westwood" ];
townsC{24} = ["Ashland","Framingham","Holliston","Hopkinton","Medway"];
townsC{25} = ["Avon","Canton","Milton","Randolph","Stoughton","West Bridgewater"];
townsC{26} = ["Fitchburg","Gardner","Leominster","Berlin","Bolton","Lancaster","Lunenburg","Sterling","Westminster","Townsend"];
townsC{27} = ["West Springfield"];

%Parallel list of towns partially covered
townsP = cell(length(reps),1);
townsP{1} = ["Attleboro","Walpole","East Walpole"];
townsP{2} = ["Lexington","Sudbury"];
townsP{3} = ["Boston","Cambridge"];
townsP{4} = ["Easton","East Bridgewater"];
townsP{5} = ["CLINTON","NORTHBOROUGH","NORTHBORO","WORCESTER"];
townsP{6} = ["none"];
townsP{7} = ["none"];
townsP{8} = ["none"];
townsP{9} = ["Sudbury","Northborough","Northboro","Southboro","Westboro"];
townsP{10} = ["Northbridge"];
townsP{11} = ["none"];
townsP{12} = ["none"];
townsP{13} = ["Braintree"];
townsP{14} = ["none"];
townsP{15} = ["Chicopee","Springfield"];
townsP{16} = ["Winchester"];
townsP{17} = ["none"];
townsP{18} = ["Northbridge","Worcester"];
townsP{19} = ["none"];
townsP{20} = ["none"];
townsP{21} = ["Franklin","Needham","Wellesley","Attleboro","Natick"];
townsP{22} = ["none"];
townsP{23} = ["Boston"];
townsP{24} = ["Natick","Franklin"];
townsP{25} = ["Braintree","Sharon","Easton","East Bridgewater"];
townsP{26} = ["Clinton"];
townsP{27} = ["Chicopee","Springfield"];


%Looping through each donation
inDistrict = [];

for i=1:height(donations)
    
    index = find(reps == string(donations.Recipient(i)));
    city = lower(string(donations(i,:).City));
    
    if distNums(index) == donations.District(i)
        inDistrict = [inDistrict, 1];
        
    elseif contains(city, lower(townsC{index}))
        inDistrict = [inDistrict, 1];
        
    elseif contains(city, lower(townsP{index})) & donations.Disctrict(i) > 40
        inDistrict = [inDistrict, NaN];
        
    elseif donations.District < 40
        inDistrict = [inDistrict, 0];
        
    elseif ismissing(city) | city == "" | city == "<missing>"
        inDistrict = [inDistrict,NaN];
        
    else inDistrict = [inDistrict, 0];
    end
    
end
inDistrict = transpose(inDistrict);