function map = ice2(m)
%ICE2 color map
%   ICE2(M) returns an M-by-3 matrix containing a colormap.
%   Modified by Anthony McDougal, using the ImageJ colormap ICE as a starting
%   point. ICE2 works well for encoding height of 3D data when visualized in 2D.

%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

%
%   EXAMPLE
%
%   This example shows how to reset the colormap of the current figure.
%
%       colormap(ice2)
%
%   See also AUTUMN, BONE, COLORCUBE, COOL, COPPER, FLAG, GRAY, HOT, HSV,
%   JET, LINES, PINK, PRISM, SPRING, SUMMER, WHITE, WINTER, COLORMAP,
%   RGBPLOT.


if nargin < 1
    f = get(groot,'CurrentFigure');
    if isempty(f)
        m = size(get(groot,'DefaultFigureColormap'),1);
    else
        m = size(f.Colormap,1);
    end
end

values = [
 0.00196078442968428	0.611335813999176	0.548835813999176
0.00196078442968428	0.617092370986939	0.554181218147278
0.00196078442968428	0.622848987579346	0.559526622295380
0.00196078442968428	0.628605544567108	0.564872026443481
0.00196078442968428	0.634362101554871	0.570217370986939
0.00196078442968428	0.640118718147278	0.575562775135040
0.00196078442968428	0.645875275135040	0.580908179283142
0.00196078442968428	0.651631891727448	0.586253583431244
0.00196078442968428	0.657388448715210	0.591598987579346
0.00196078442968428	0.663145005702972	0.596944391727448
0.00196078442968428	0.668901622295380	0.602289736270905
0.00196078442968428	0.674658179283142	0.607635140419006
0.00196078442968428	0.680414736270905	0.612980544567108
0.00196078442968428	0.686171352863312	0.618325948715210
0.00196078442968428	0.691927909851074	0.623671352863312
0.00196078442968428	0.697684526443481	0.629016757011414
0.00196078442968428	0.703441083431244	0.634362101554871
0.00196078442968428	0.709197640419006	0.639707505702972
0.00196078442968428	0.714954257011414	0.645052909851074
0.00196078442968428	0.720710813999176	0.650398313999176
0.00183006550651044	0.723643839359283	0.652790069580078
0.00169934646692127	0.726576805114746	0.655181825160980
0.00156862754374743	0.729509830474854	0.657573580741882
0.00143790862057358	0.732442855834961	0.659965276718140
0.00130718958098441	0.735375821590424	0.662357032299042
0.00117647065781057	0.738308846950531	0.664748787879944
0.00104575173463672	0.741241872310638	0.667140543460846
0.000915032753255218	0.744174838066101	0.669532299041748
0.000784313771873713	0.747107863426209	0.671924054622650
0.000653594790492207	0.750040888786316	0.674315810203552
0.000522875867318362	0.752973854541779	0.676707565784454
0.000392156885936856	0.755906879901886	0.679099261760712
0.000261437933659181	0.758839905261993	0.681491017341614
0.000130718966829591	0.761772871017456	0.683882772922516
0	0.764705896377564	0.686274528503418
0.00476122088730335	0.764153480529785	0.694530308246613
0.00952244177460671	0.763601064682007	0.702786087989807
0.0142836626619101	0.763048589229584	0.711041867733002
0.0190448835492134	0.762496173381805	0.719297647476196
0.0238061044365168	0.761943757534027	0.727553427219391
0.0285673253238201	0.761391341686249	0.735809206962585
0.0333285480737686	0.760838925838471	0.744064986705780
0.0380897670984268	0.760286450386047	0.752320766448975
0.0428509861230850	0.759734034538269	0.760576605796814
0.0476122088730335	0.759181618690491	0.768832385540009
0.0523734316229820	0.758629202842712	0.777088165283203
0.0571346506476402	0.758076786994934	0.785343945026398
0.0618958696722984	0.757524371147156	0.793599724769592
0.0666570961475372	0.756971895694733	0.801855504512787
0.0714183151721954	0.756419479846954	0.810111284255981
0.0761795341968536	0.755867063999176	0.818367063999176
0.0829069614410400	0.751092731952667	0.823792397975922
0.0896343961358070	0.746318459510803	0.829217731952667
0.0963618233799934	0.741544127464294	0.834643125534058
0.103089258074760	0.736769855022430	0.840068459510803
0.109816685318947	0.731995522975922	0.845493793487549
0.116544120013714	0.727221250534058	0.850919127464294
0.123271547257900	0.722446918487549	0.856344521045685
0.129998981952667	0.717672646045685	0.861769855022430
0.136726409196854	0.712898313999176	0.867195188999176
0.143453836441040	0.708123981952667	0.872620522975922
0.150181263685226	0.703349709510803	0.878045856952667
0.156908705830574	0.698575377464294	0.883471250534058
0.163636133074760	0.693801105022430	0.888896584510803
0.170363560318947	0.689026772975922	0.894321918487549
0.177090987563133	0.684252500534058	0.899747252464294
0.183818429708481	0.679478168487549	0.905172646045685
0.190545856952667	0.674703896045685	0.910597980022430
0.197273284196854	0.669929563999176	0.916023313999176
0.196622237563133	0.666999876499176	0.913093626499176
0.195971205830574	0.664070188999176	0.910163938999176
0.195320159196854	0.661140501499176	0.907234251499176
0.194669112563133	0.658210813999176	0.904304563999176
0.194018080830574	0.655281126499176	0.901374876499176
0.193367034196854	0.652351438999176	0.898445188999176
0.192715987563133	0.649421751499176	0.895515501499176
0.192064955830574	0.646492063999176	0.892585813999176
0.191413909196854	0.643562376499176	0.889656126499176
0.190762862563133	0.640632688999176	0.886726438999176
0.190111830830574	0.637703001499176	0.883796751499176
0.189460784196854	0.634773313999176	0.880867063999176
0.200268074870110	0.627872288227081	0.883992075920105
0.211075365543365	0.620971202850342	0.887117087841034
0.221882656216621	0.614070177078247	0.890242040157318
0.232689961791039	0.607169151306152	0.893367052078247
0.243497252464294	0.600268125534058	0.896492063999176
0.254304528236389	0.593367040157318	0.899617075920105
0.265111833810806	0.586466014385223	0.902742087841034
0.275919139385223	0.579564988613129	0.905867040157318
0.286726415157318	0.572663903236389	0.908992052078247
0.297533720731735	0.565762877464294	0.912117063999176
0.308340996503830	0.558861851692200	0.915242075920105
0.319148302078247	0.551960825920105	0.918367087841034
0.329955577850342	0.545059740543366	0.921492040157318
0.340762883424759	0.538158714771271	0.924617052078247
0.351570188999176	0.531257688999176	0.927742063999176
0.362377464771271	0.524356603622437	0.930867075920105
0.373184770345688	0.517455577850342	0.933992087841034
0.383992046117783	0.510554552078247	0.937117040157318
0.394799351692200	0.503653526306152	0.940242052078247
0.405606627464294	0.496752470731735	0.943367063999176
0.416413933038712	0.489851415157318	0.946492075920105
0.427221208810806	0.482950389385223	0.949617087841034
0.438028514385223	0.476049333810806	0.952742040157318
0.448835819959641	0.469148278236389	0.955867052078247
0.459643095731735	0.462247252464294	0.958992063999176
0.470450401306152	0.455346196889877	0.962117075920105
0.481257677078247	0.448445171117783	0.965242087841034
0.492064982652664	0.441544115543366	0.968367040157318
0.502872288227081	0.434643089771271	0.971492052078247
0.513679563999176	0.427742034196854	0.974617063999176
0.520515501499176	0.424324065446854	0.974739134311676
0.527351438999176	0.420906096696854	0.974861204624176
0.534187376499176	0.417488127946854	0.974983274936676
0.541023313999176	0.414070159196854	0.975105345249176
0.547859251499176	0.410652190446854	0.975227415561676
0.554695188999176	0.407234221696854	0.975349485874176
0.561531126499176	0.403816252946854	0.975471556186676
0.568367063999176	0.400398284196854	0.975593626499176
0.575203001499176	0.396980315446854	0.975715696811676
0.582038938999176	0.393562346696854	0.975837767124176
0.588874876499176	0.390144377946854	0.975959837436676
0.595710813999176	0.386726409196854	0.976081907749176
0.602546751499176	0.383308440446854	0.976203978061676
0.609382688999176	0.379890471696854	0.976326048374176
0.616218626499176	0.376472502946854	0.976448118686676
0.623054563999176	0.373054534196854	0.976570188999176
0.629890501499176	0.369636565446854	0.976692259311676
0.636726438999176	0.366218596696854	0.976814329624176
0.643562376499176	0.362800627946854	0.976936399936676
0.650398313999176	0.359382659196854	0.977058470249176
0.657234251499176	0.355964690446854	0.977180540561676
0.664070188999176	0.352546721696854	0.977302610874176
0.670906126499176	0.349128752946854	0.977424681186676
0.677742063999176	0.345710784196854	0.977546751499176
0.684578001499176	0.342292815446854	0.977668821811676
0.691413938999176	0.338874846696854	0.977790892124176
0.698249876499176	0.335456877946854	0.977912962436676
0.705085813999176	0.332038909196854	0.978035032749176
0.711921751499176	0.328620940446854	0.978157103061676
0.718757688999176	0.325202971696854	0.978279173374176
0.725593626499176	0.321785002946854	0.978401243686676
0.732429563999176	0.318367034196854	0.978523313999176
0.737556517124176	0.320320159196854	0.976081907749176
0.742683470249176	0.322273284196854	0.973640501499176
0.747810423374176	0.324226409196854	0.971199095249176
0.752937376499176	0.326179534196854	0.968757688999176
0.758064329624176	0.328132659196854	0.966316282749176
0.763191282749176	0.330085784196854	0.963874876499176
0.768318235874176	0.332038909196854	0.961433470249176
0.773445188999176	0.333992034196854	0.958992063999176
0.778572142124176	0.335945159196854	0.956550657749176
0.783699095249176	0.337898284196854	0.954109251499176
0.788826048374176	0.339851409196854	0.951667845249176
0.793953001499176	0.341804534196854	0.949226438999176
0.799079954624176	0.343757659196854	0.946785032749176
0.804206907749176	0.345710784196854	0.944343626499176
0.809333860874176	0.347663909196854	0.941902220249176
0.814460813999176	0.349617034196854	0.939460813999176
0.819587767124176	0.351570159196854	0.937019407749176
0.824714720249176	0.353523284196854	0.934578001499176
0.829841673374176	0.355476409196854	0.932136595249176
0.834968626499176	0.357429534196854	0.929695188999176
0.840095579624176	0.359382659196854	0.927253782749176
0.845222532749176	0.361335784196854	0.924812376499176
0.850349485874176	0.363288909196854	0.922370970249176
0.855476438999176	0.365242034196854	0.919929563999176
0.860603392124176	0.367195159196854	0.917488157749176
0.865730345249176	0.369148284196854	0.915046751499176
0.870857298374176	0.371101409196854	0.912605345249176
0.875984251499176	0.373054534196854	0.910163938999176
0.881111204624176	0.375007659196854	0.907722532749176
0.886238157749176	0.376960784196854	0.905281126499176
0.891365110874176	0.378913909196854	0.902839720249176
0.896492063999176	0.380867034196854	0.900398313999176
0.900809526443481	0.380044668912888	0.898753583431244
0.905126929283142	0.379222303628922	0.897108852863312
0.909444391727448	0.378399938344955	0.895464122295380
0.913761794567108	0.377577573060989	0.893819391727448
0.918079257011414	0.376755177974701	0.892174601554871
0.922396659851074	0.375932812690735	0.890529870986939
0.926714122295380	0.375110447406769	0.888885140419006
0.931031525135040	0.374288082122803	0.887240409851074
0.935348987579346	0.373465716838837	0.885595679283142
0.939666390419006	0.372643351554871	0.883950948715210
0.943983852863312	0.371820986270905	0.882306218147278
0.948301255702972	0.370998620986939	0.880661487579346
0.952618718147278	0.370176255702972	0.879016757011414
0.956936120986939	0.369353890419006	0.877372026443481
0.961253583431244	0.368531495332718	0.875727236270905
0.965570986270905	0.367709130048752	0.874082505702972
0.969888448715210	0.366886764764786	0.872437775135040
0.974205851554871	0.366064399480820	0.870793044567108
0.978523313999176	0.365242034196854	0.869148313999176
0.978523313999176	0.360945165157318	0.853913962841034
0.978523313999176	0.356648296117783	0.838679552078247
0.978523313999176	0.352351397275925	0.823445200920105
0.978523313999176	0.348054528236389	0.808210790157318
0.978523313999176	0.343757659196854	0.792976438999176
0.978523313999176	0.339460790157318	0.777742087841034
0.978523313999176	0.335163921117783	0.762507677078247
0.978523313999176	0.330867022275925	0.747273325920105
0.978523313999176	0.326570153236389	0.732038915157318
0.978523313999176	0.322273284196854	0.716804563999176
0.978523313999176	0.317976415157318	0.701570212841034
0.978523313999176	0.313679546117783	0.686335802078247
0.978523313999176	0.309382647275925	0.671101450920105
0.978523313999176	0.305085778236389	0.655867040157318
0.978523313999176	0.300788909196854	0.640632688999176
0.978523313999176	0.296492040157318	0.625398337841034
0.978523313999176	0.292195171117783	0.610163927078247
0.978523313999176	0.287898272275925	0.594929575920105
0.978523313999176	0.283601403236389	0.579695165157318
0.978523313999176	0.279304534196854	0.564460813999176
0.978667974472046	0.269032537937164	0.552886724472046
0.978812694549561	0.258760541677475	0.541312634944916
0.978957355022430	0.248488560318947	0.529738605022430
0.979102015495300	0.238216564059258	0.518164515495300
0.979246675968170	0.227944582700729	0.506590425968170
0.979391396045685	0.217672586441040	0.495016366243362
0.979536056518555	0.207400605082512	0.483442276716232
0.979680716991425	0.197128608822823	0.471868216991425
0.979825377464294	0.186856612563133	0.460294127464294
0.979970097541809	0.176584631204605	0.448720067739487
0.980114758014679	0.166312634944916	0.437145978212357
0.980259418487549	0.156040638685226	0.425571918487549
0.980404078960419	0.145768657326698	0.413997828960419
0.980548799037933	0.135496661067009	0.402423769235611
0.980693459510803	0.125224679708481	0.390849679708481
0.980838119983673	0.114952683448792	0.379275619983673
0.980982780456543	0.104680694639683	0.367701530456543
0.981127500534058	0.0944086983799934	0.356127470731735
0.981272161006928	0.0841367095708847	0.344553381204605
0.981416821479797	0.0738647207617760	0.332979321479797
0.981561481952667	0.0635927319526672	0.321405231952667
0.981706202030182	0.0533207394182682	0.309831172227860
0.981850862503052	0.0430487468838692	0.298257082700729
0.981995522975922	0.0327767580747604	0.286683022975922
0.982140183448792	0.0225047655403614	0.275108933448792
0.982284903526306	0.0122327748686075	0.263534873723984
0.982429563999176	0.00196078442968428	0.251960784196854
0.977221250534058	0.00456495117396116	0.227221205830574
0.972012877464294	0.00716911768540740	0.202481612563133
0.966804563999176	0.00977328419685364	0.177742034196854
0.961596250534058	0.0123774511739612	0.153002455830574
0.956387877464294	0.0149816172197461	0.128262862563133
0.951179563999176	0.0175857841968536	0.103523284196854
0.943925082683563	0.0153536414727569	0.104081317782402
0.936670660972595	0.0131214987486601	0.104639358818531
0.929416179656982	0.0108893560245633	0.105197392404079
0.922161698341370	0.00865721330046654	0.105755425989628
0.914907217025757	0.00642507011070848	0.106313459575176
0.907652795314789	0.00419292738661170	0.106871500611305
0.900398313999176	0.00196078442968428	0.107429534196854
0.900398313999176	0.00196078442968428	0.107429534196854
0.900398313999176	0.00196078442968428	0.107429534196854
    ];

P = size(values,1);
map = interp1(1:size(values,1), values, linspace(1,P,m), 'linear');