%completeDistributionAnalysis
%Sourced from distributionAnalysis but for all representatives for comp.

load('senators.mat');
load('donations.mat');
load('demographics.mat');

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

%Cell structure with amounts per rep per district status(in,out,unknown)
data = cell(length(reps),3);

%Looping through each representative
for rep = 1:length(reps)
    
    %Preallocating arrays
    amount = [];
    inDistrict = [];
    donorIndices = [];
    inDistrictAmount = [];
    outDistrictAmount = [];
    
    %Finding index for chosen rep
    index = find(senators.Senator == reps(rep));
    distNum = senators(index,:).DistNum;
    
    %Increasing the count to indicate a row read from the database
    count = 1;

    for i = 1:height(donations)

        %setting the name of the row's representative
        row = string(donations(i,:).Recipient);

        %if the row's rep isn't our current target rep
        if row ~= reps(rep)
            
            %move down a row and continue
            count = count+1;
            continue
        end

        %If it is, record the amount into our amount array
        amount = [amount,donations(i,:).Amount];

        %Take the lowercase of the city in the row
        city = lower(string(donations(i,:).City));
        
        %If the district matches up, label boolean as in district
        if donations(i,:).VarName24 == distNums(rep)
            inDistrict = [inDistrict,1];
            
        %If the district doesn't or is unknown, see if towns match
        %If towns match, label boolean as in district
        elseif find(city == lower(townsC{rep}))
            inDistrict = [inDistrict,1];
            
        %If towns are in partial match or are unknown, label as unknown
        elseif find(city == lower(townsP{rep}))
            inDistrict = [inDistrict,NaN];
        elseif ismissing(city)
            inDistrict = [inDistrict,NaN];
        
        %If none of those, label boolean as out of district
        else 
            inDistrict = [inDistrict,0];
        end   

        %Make a label of the indices taken for auditing
        donorIndices = [donorIndices, count];
        count = count+1;
    end
    %% 
    %Locate our unknown values
    %Save those amounts
    unknown = find(ismissing(inDistrict)==1);
    ukAmount = amount(unknown);
    
    %Calculate our in District amounts
    inDistrictAmount = amount.*inDistrict;
    
    %From that calculate the out of District amounts
    outDistrictAmount = amount - inDistrictAmount;

    %Remove the zeros that indicate position, don't need parallel arrays
    inDistrictAmount = rmmissing(nonzeros(inDistrictAmount));
    outDistrictAmount = rmmissing(nonzeros(outDistrictAmount));
    
    %Save into master data cell
    data{index,1} = inDistrictAmount;
    data{index,2} = outDistrictAmount;
    data{index,3} = ukAmount;
    
    %% THE BELOW Sections are only used when plotting for accumulations.

%     %Accumulation function visualization
%
%     %Sort Functions min to max
%     inDistrictAmount = sort(inDistrictAmount);
%     sxIn = [0];
%     for i = 2:length(inDistrictAmount)+1
%         sxIn = [sxIn,sxIn(i-1)+inDistrictAmount(i-1)];
%     end
% 
%     outDistrictAmount = sort(outDistrictAmount);
%     sxOut = [0];
%     for i = 2:length(outDistrictAmount)+1
%         sxOut = [sxOut,sxOut(i-1)+outDistrictAmount(i-1)];
%     end
% 
%     sxUk = [0];
%     for i = 2:length(unknown)+1
%         sxUk = [sxUk,sxUk(i-1)+ amount(unknown(i-1))];
%     end
    %% 
    %For helping with plots
%     adjOutDistrictAmount = [zeros(length(inDistrictAmount),1);outDistrictAmount];
%     figure()
%     area(adjOutDistrictAmount)
%     hold on
%     area(inDistrictAmount)
%     area(sort(amount(unknown)))
%     title(reps(rep));
%     legend("Out of District","In District","No Data")
%     hold off
% 
%     figure()
%     plot(sxOut,'LineWidth',5)
%     hold on
%     plot(sxIn,'LineWidth',5)
%     plot(sxUk, 'LineWidth',5)
%     title(reps(rep));
%     legend("Out of District","In District","No Data")
%     hold off

end