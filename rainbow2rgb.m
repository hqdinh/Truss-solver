% Uncomment the code below (line 2 - 13) & run section to see in action:
% clc; clear; close all;
% N = 749;
% x = linspace(-0,1,N);
% y = sin(5*pi*x).*exp(x);
% colors = rainbow2rgb(x);
% 
% figure 
% hold on
% for i=1:N
%     plot(x(i), y(i), 'o', 'color', colors(i,:))
% end 
% title('Color depends on x')

function color = rainbow2rgb(k)
    % returns a normalized RGB vector [red green blue] from vector k
    % k is the color position in the visible spectrum:
    % k = 0.00 = purple
    % k = 1.00 = red 
    assert(prod((k>=0).*(k<=1))==1, 'All k values must be between 0 and 1');
    data = get_data();
    data = data / 255;  % normalize the color for MATLAB
    scaling = linspace(0, 1, size(data,1))';
    data = [scaling data];
    color = zeros(length(k), 3); 
    for i=1:length(k)
        index = find(data >= k(i), 1, 'first');
        color(i,:) = data(index, 2:4);  % color(i,:) = [red green blue]
    end
end 

function data = get_data()
    % contains 749 colors in RGB in the visible spectrum i.e. rainbow, 
    % ranging from purple to red
    data = [84.00   0.00    159.00
            84.00   0.00    160.00
            84.00   0.00    161.00
            84.00   0.00    162.00
            84.00   0.00    163.00
            84.00   0.00    164.25
            84.00   0.00    165.50
            84.00   0.00    166.75
            84.00   0.00    168.00
            82.75   0.00    170.25
            81.50   0.00    172.50
            80.25   0.00    174.75
            79.00   0.00    177.00
            78.75   0.00    178.25
            78.50   0.00    179.50
            78.25   0.00    180.75
            78.00   0.00    182.00
            77.75   0.00    183.00
            77.50   0.00    184.00
            77.25   0.00    185.00
            77.00   0.00    186.00
            76.75   0.00    187.25
            76.50   0.00    188.50
            76.25   0.00    189.75
            76.00   0.00    191.00
            74.50   0.00    193.25
            73.00   0.00    195.50
            71.50   0.00    197.75
            70.00   0.00    200.00
            69.50   0.00    201.00
            69.00   0.00    202.00
            68.50   0.00    203.00
            68.00   0.00    204.00
            67.50   0.00    205.25
            67.00   0.00    206.50
            66.50   0.00    207.75
            66.00   0.00    209.00
            64.50   0.00    210.25
            63.00   0.00    211.50
            61.50   0.00    212.75
            60.00   0.00    214.00
            59.50   0.00    215.00
            59.00   0.00    216.00
            58.50   0.00    217.00
            58.00   0.00    218.00
            57.25   0.00    219.25
            56.50   0.00    220.50
            55.75   0.00    221.75
            55.00   0.00    223.00
            52.75   0.00    225.25
            50.50   0.00    227.50
            48.25   0.00    229.75
            46.00   0.00    232.00
            45.25   0.00    233.00
            44.50   0.00    234.00
            43.75   0.00    235.00
            43.00   0.00    236.00
            42.25   0.00    237.25
            41.50   0.00    238.50
            40.75   0.00    239.75
            40.00   0.00    241.00
            39.00   0.00    242.00
            38.00   0.00    243.00
            37.00   0.00    244.00
            36.00   0.00    245.00
            35.25   0.00    246.25
            34.50   0.00    247.50
            33.75   0.00    248.75
            33.00   0.00    250.00
            31.00   0.00    251.25
            29.00   0.00    252.50
            27.00   0.00    253.75
            25.00   0.00    255.00
            22.75   0.00    255.00
            20.50   0.00    255.00
            18.25   0.00    255.00
            16.00   0.00    255.00
            15.00   0.00    255.00
            14.00   0.00    255.00
            13.00   0.00    255.00
            12.00   0.00    255.00
            10.00   0.00    255.00
            8.00    0.00    255.00
            6.00    0.00    255.00
            4.00    0.00    255.00
            3.00    0.00    255.00
            2.00    0.00    255.00
            1.00    0.00    255.00
            0.00    0.00    255.00
            0.00    1.00    255.00
            0.00    2.00    255.00
            0.00    3.00    255.00
            0.00    4.00    255.00
            0.00    7.00    255.00
            0.00    10.00   255.00
            0.00    13.00   255.00
            0.00    16.00   255.00
            0.00    17.25   255.00
            0.00    18.50   255.00
            0.00    19.75   255.00
            0.00    21.00   255.00
            0.00    22.00   255.00
            0.00    23.00   255.00
            0.00    24.00   255.00
            0.00    25.00   255.00
            0.00    26.00   255.00
            0.00    27.00   255.00
            0.00    28.00   255.00
            0.00    29.00   255.00
            0.00    31.25   255.00
            0.00    33.50   255.00
            0.00    35.75   255.00
            0.00    38.00   255.00
            0.00    39.00   255.00
            0.00    40.00   255.00
            0.00    41.00   255.00
            0.00    42.00   255.00
            0.00    43.00   255.00
            0.00    44.00   255.00
            0.00    45.00   255.00
            0.00    46.00   255.00
            0.00    47.25   255.00
            0.00    48.50   255.00
            0.00    49.75   255.00
            0.00    51.00   255.00
            0.00    54.00   255.00
            0.00    57.00   255.00
            0.00    60.00   255.00
            0.00    63.00   255.00
            0.00    64.00   255.00
            0.00    65.00   255.00
            0.00    66.00   255.00
            0.00    67.00   255.00
            0.00    68.25   255.00
            0.00    69.50   255.00
            0.00    70.75   255.00
            0.00    72.00   255.00
            0.00    75.00   255.00
            0.00    78.00   255.00
            0.00    81.00   255.00
            0.00    84.00   255.00
            0.00    85.25   255.00
            0.00    86.50   255.00
            0.00    87.75   255.00
            0.00    89.00   255.00
            0.00    90.00   255.00
            0.00    91.00   255.00
            0.00    92.00   255.00
            0.00    93.00   255.00
            0.00    94.00   255.00
            0.00    95.00   255.00
            0.00    96.00   255.00
            0.00    97.00   255.00
            0.00    99.25   255.00
            0.00    101.50  255.00
            0.00    103.75  255.00
            0.00    106.00  255.00
            0.00    107.00  255.00
            0.00    108.00  255.00
            0.00    109.00  255.00
            0.00    110.00  255.00
            0.00    111.00  255.00
            0.00    112.00  255.00
            0.00    113.00  255.00
            0.00    114.00  255.00
            0.00    115.25  255.00
            0.00    116.50  255.00
            0.00    117.75  255.00
            0.00    119.00  255.00
            0.00    121.00  255.00
            0.00    123.00  255.00
            0.00    125.00  255.00
            0.00    127.00  255.00
            0.00    129.00  255.00
            0.00    131.00  255.00
            0.00    133.00  255.00
            0.00    135.00  255.00
            0.00    136.25  255.00
            0.00    137.50  255.00
            0.00    138.75  255.00
            0.00    140.00  255.00
            0.00    143.00  255.00
            0.00    146.00  255.00
            0.00    149.00  255.00
            0.00    152.00  255.00
            0.00    153.25  255.00
            0.00    154.50  255.00
            0.00    155.75  255.00
            0.00    157.00  255.00
            0.00    158.00  255.00
            0.00    159.00  255.00
            0.00    160.00  255.00
            0.00    161.00  255.00
            0.00    162.00  255.00
            0.00    163.00  255.00
            0.00    164.00  255.00
            0.00    165.00  255.00
            0.00    167.25  255.00
            0.00    169.50  255.00
            0.00    171.75  255.00
            0.00    174.00  255.00
            0.00    175.00  255.00
            0.00    176.00  255.00
            0.00    177.00  255.00
            0.00    178.00  255.00
            0.00    179.00  255.00
            0.00    180.00  255.00
            0.00    181.00  255.00
            0.00    182.00  255.00
            0.00    183.25  255.00
            0.00    184.50  255.00
            0.00    185.75  255.00
            0.00    187.00  255.00
            0.00    189.00  255.00
            0.00    191.00  255.00
            0.00    193.00  255.00
            0.00    195.00  255.00
            0.00    196.00  255.00
            0.00    197.00  255.00
            0.00    198.00  255.00
            0.00    199.00  255.00
            0.00    203.25  255.00
            0.00    207.50  255.00
            0.00    211.75  255.00
            0.00    216.00  255.00
            0.00    217.00  255.00
            0.00    218.00  255.00
            0.00    219.00  255.00
            0.00    220.00  255.00
            0.00    221.25  255.00
            0.00    222.50  255.00
            0.00    223.75  255.00
            0.00    225.00  255.00
            0.00    226.00  255.00
            0.00    227.00  255.00
            0.00    228.00  255.00
            0.00    229.00  255.00
            0.00    230.00  255.00
            0.00    231.00  255.00
            0.00    232.00  255.00
            0.00    233.00  255.00
            0.00    235.25  255.00
            0.00    237.50  255.00
            0.00    239.75  255.00
            0.00    242.00  255.00
            0.00    243.00  255.00
            0.00    244.00  255.00
            0.00    245.00  255.00
            0.00    246.00  255.00
            0.00    247.00  255.00
            0.00    248.00  255.00
            0.00    249.00  255.00
            0.00    250.00  255.00
            0.00    251.25  255.00
            0.00    252.50  255.00
            0.00    253.75  255.00
            0.00    255.00  255.00
            0.00    255.00  252.75
            0.00    255.00  250.50
            0.00    255.00  248.25
            0.00    255.00  246.00
            0.00    255.00  245.00
            0.00    255.00  244.00
            0.00    255.00  243.00
            0.00    255.00  242.00
            0.00    255.00  241.00
            0.00    255.00  240.00
            0.00    255.00  239.00
            0.00    255.00  238.00
            0.00    255.00  234.75
            0.00    255.00  231.50
            0.00    255.00  228.25
            0.00    255.00  225.00
            0.00    255.00  222.75
            0.00    255.00  220.50
            0.00    255.00  218.25
            0.00    255.00  216.00
            0.00    255.00  215.00
            0.00    255.00  214.00
            0.00    255.00  213.00
            0.00    255.00  212.00
            0.00    255.00  209.75
            0.00    255.00  207.50
            0.00    255.00  205.25
            0.00    255.00  203.00
            0.00    255.00  202.00
            0.00    255.00  201.00
            0.00    255.00  200.00
            0.00    255.00  199.00
            0.00    255.00  198.00
            0.00    255.00  197.00
            0.00    255.00  196.00
            0.00    255.00  195.00
            0.00    255.00  194.00
            0.00    255.00  193.00
            0.00    255.00  192.00
            0.00    255.00  191.00
            0.00    255.00  190.00
            0.00    255.00  189.00
            0.00    255.00  188.00
            0.00    255.00  187.00
            0.00    255.00  184.75
            0.00    255.00  182.50
            0.00    255.00  180.25
            0.00    255.00  178.00
            0.00    255.00  177.00
            0.00    255.00  176.00
            0.00    255.00  175.00
            0.00    255.00  174.00
            0.00    255.00  173.00
            0.00    255.00  172.00
            0.00    255.00  171.00
            0.00    255.00  170.00
            0.00    255.00  166.75
            0.00    255.00  163.50
            0.00    255.00  160.25
            0.00    255.00  157.00
            0.00    255.00  155.75
            0.00    255.00  154.50
            0.00    255.00  153.25
            0.00    255.00  152.00
            0.00    255.00  150.00
            0.00    255.00  148.00
            0.00    255.00  146.00
            0.00    255.00  144.00
            0.00    255.00  141.75
            0.00    255.00  139.50
            0.00    255.00  137.25
            0.00    255.00  135.00
            0.00    255.00  134.00
            0.00    255.00  133.00
            0.00    255.00  132.00
            0.00    255.00  131.00
            0.00    255.00  130.00
            0.00    255.00  129.00
            0.00    255.00  128.00
            0.00    255.00  127.00
            0.00    255.00  126.00
            0.00    255.00  125.00
            0.00    255.00  124.00
            0.00    255.00  123.00
            0.00    255.00  120.75
            0.00    255.00  118.50
            0.00    255.00  116.25
            0.00    255.00  114.00
            0.00    255.00  113.00
            0.00    255.00  112.00
            0.00    255.00  111.00
            0.00    255.00  110.00
            0.00    255.00  109.00
            0.00    255.00  108.00
            0.00    255.00  107.00
            0.00    255.00  106.00
            0.00    255.00  105.00
            0.00    255.00  104.00
            0.00    255.00  103.00
            0.00    255.00  102.00
            0.00    255.00  98.75
            0.00    255.00  95.50
            0.00    255.00  92.25
            0.00    255.00  89.00
            0.00    255.00  87.75
            0.00    255.00  86.50
            0.00    255.00  85.25
            0.00    255.00  84.00
            0.00    255.00  83.00
            0.00    255.00  82.00
            0.00    255.00  81.00
            0.00    255.00  80.00
            0.00    255.00  79.00
            0.00    255.00  78.00
            0.00    255.00  77.00
            0.00    255.00  76.00
            0.00    255.00  72.75
            0.00    255.00  69.50
            0.00    255.00  66.25
            0.00    255.00  63.00
            0.00    255.00  62.00
            0.00    255.00  61.00
            0.00    255.00  60.00
            0.00    255.00  59.00
            0.00    255.00  58.00
            0.00    255.00  57.00
            0.00    255.00  56.00
            0.00    255.00  55.00
            0.00    255.00  52.75
            0.00    255.00  50.50
            0.00    255.00  48.25
            0.00    255.00  46.00
            0.00    255.00  45.00
            0.00    255.00  44.00
            0.00    255.00  43.00
            0.00    255.00  42.00
            0.00    255.00  41.00
            0.00    255.00  40.00
            0.00    255.00  39.00
            0.00    255.00  38.00
            0.00    255.00  34.75
            0.00    255.00  31.50
            0.00    255.00  28.25
            0.00    255.00  25.00
            0.00    255.00  24.00
            0.00    255.00  23.00
            0.00    255.00  22.00
            0.00    255.00  21.00
            0.00    255.00  19.75
            0.00    255.00  18.50
            0.00    255.00  17.25
            0.00    255.00  16.00
            0.00    255.00  15.00
            0.00    255.00  14.00
            0.00    255.00  13.00
            0.00    255.00  12.00
            0.00    255.00  11.00
            0.00    255.00  10.00
            0.00    255.00  9.00
            0.00    255.00  8.00
            0.00    255.00  6.00
            0.00    255.00  4.00
            0.00    255.00  2.00
            0.00    255.00  0.00
            2.00    255.00  0.00
            4.00    255.00  0.00
            6.00    255.00  0.00
            8.00    255.00  0.00
            9.00    255.00  0.00
            10.00   255.00  0.00
            11.00   255.00  0.00
            12.00   255.00  0.00
            14.25   255.00  0.00
            16.50   255.00  0.00
            18.75   255.00  0.00
            21.00   255.00  0.00
            22.00   255.00  0.00
            23.00   255.00  0.00
            24.00   255.00  0.00
            25.00   255.00  0.00
            26.00   255.00  0.00
            27.00   255.00  0.00
            28.00   255.00  0.00
            29.00   255.00  0.00
            32.25   255.00  0.00
            35.50   255.00  0.00
            38.75   255.00  0.00
            42.00   255.00  0.00
            43.00   255.00  0.00
            44.00   255.00  0.00
            45.00   255.00  0.00
            46.00   255.00  0.00
            47.25   255.00  0.00
            48.50   255.00  0.00
            49.75   255.00  0.00
            51.00   255.00  0.00
            52.00   255.00  0.00
            53.00   255.00  0.00
            54.00   255.00  0.00
            55.00   255.00  0.00
            57.00   255.00  0.00
            59.00   255.00  0.00
            61.00   255.00  0.00
            63.00   255.00  0.00
            64.00   255.00  0.00
            65.00   255.00  0.00
            66.00   255.00  0.00
            67.00   255.00  0.00
            68.25   255.00  0.00
            69.50   255.00  0.00
            70.75   255.00  0.00
            72.00   255.00  0.00
            73.00   255.00  0.00
            74.00   255.00  0.00
            75.00   255.00  0.00
            76.00   255.00  0.00
            79.25   255.00  0.00
            82.50   255.00  0.00
            85.75   255.00  0.00
            89.00   255.00  0.00
            90.00   255.00  0.00
            91.00   255.00  0.00
            92.00   255.00  0.00
            93.00   255.00  0.00
            94.00   255.00  0.00
            95.00   255.00  0.00
            96.00   255.00  0.00
            97.00   255.00  0.00
            100.25  255.00  0.00
            103.50  255.00  0.00
            106.75  255.00  0.00
            110.00  255.00  0.00
            111.00  255.00  0.00
            112.00  255.00  0.00
            113.00  255.00  0.00
            114.00  255.00  0.00
            115.25  255.00  0.00
            116.50  255.00  0.00
            117.75  255.00  0.00
            119.00  255.00  0.00
            120.00  255.00  0.00
            121.00  255.00  0.00
            122.00  255.00  0.00
            123.00  255.00  0.00
            125.00  255.00  0.00
            127.00  255.00  0.00
            129.00  255.00  0.00
            131.00  255.00  0.00
            132.00  255.00  0.00
            133.00  255.00  0.00
            134.00  255.00  0.00
            135.00  255.00  0.00
            136.25  255.00  0.00
            137.50  255.00  0.00
            138.75  255.00  0.00
            140.00  255.00  0.00
            141.00  255.00  0.00
            142.00  255.00  0.00
            143.00  255.00  0.00
            144.00  255.00  0.00
            146.25  255.00  0.00
            148.50  255.00  0.00
            150.75  255.00  0.00
            153.00  255.00  0.00
            155.00  255.00  0.00
            157.00  255.00  0.00
            159.00  255.00  0.00
            161.00  255.00  0.00
            162.00  255.00  0.00
            163.00  255.00  0.00
            164.00  255.00  0.00
            165.00  255.00  0.00
            168.25  255.00  0.00
            171.50  255.00  0.00
            174.75  255.00  0.00
            178.00  255.00  0.00
            179.00  255.00  0.00
            180.00  255.00  0.00
            181.00  255.00  0.00
            182.00  255.00  0.00
            183.25  255.00  0.00
            184.50  255.00  0.00
            185.75  255.00  0.00
            187.00  255.00  0.00
            188.00  255.00  0.00
            189.00  255.00  0.00
            190.00  255.00  0.00
            191.00  255.00  0.00
            193.00  255.00  0.00
            195.00  255.00  0.00
            197.00  255.00  0.00
            199.00  255.00  0.00
            200.00  255.00  0.00
            201.00  255.00  0.00
            202.00  255.00  0.00
            203.00  255.00  0.00
            204.25  255.00  0.00
            205.50  255.00  0.00
            206.75  255.00  0.00
            208.00  255.00  0.00
            209.00  255.00  0.00
            210.00  255.00  0.00
            211.00  255.00  0.00
            212.00  255.00  0.00
            214.25  255.00  0.00
            216.50  255.00  0.00
            218.75  255.00  0.00
            221.00  255.00  0.00
            222.00  255.00  0.00
            223.00  255.00  0.00
            224.00  255.00  0.00
            225.00  255.00  0.00
            229.25  255.00  0.00
            233.50  255.00  0.00
            237.75  255.00  0.00
            242.00  255.00  0.00
            243.00  255.00  0.00
            244.00  255.00  0.00
            245.00  255.00  0.00
            246.00  255.00  0.00
            247.00  255.00  0.00
            248.00  255.00  0.00
            249.00  255.00  0.00
            250.00  255.00  0.00
            251.25  255.00  0.00
            252.50  255.00  0.00
            253.75  255.00  0.00
            255.00  255.00  0.00
            255.00  253.75  0.00
            255.00  252.50  0.00
            255.00  251.25  0.00
            255.00  250.00  0.00
            255.00  248.00  0.00
            255.00  246.00  0.00
            255.00  244.00  0.00
            255.00  242.00  0.00
            255.00  241.00  0.00
            255.00  240.00  0.00
            255.00  239.00  0.00
            255.00  238.00  0.00
            255.00  236.75  0.00
            255.00  235.50  0.00
            255.00  234.25  0.00
            255.00  233.00  0.00
            255.00  232.00  0.00
            255.00  231.00  0.00
            255.00  230.00  0.00
            255.00  229.00  0.00
            255.00  227.00  0.00
            255.00  225.00  0.00
            255.00  223.00  0.00
            255.00  221.00  0.00
            255.00  219.75  0.00
            255.00  218.50  0.00
            255.00  217.25  0.00
            255.00  216.00  0.00
            255.00  215.00  0.00
            255.00  214.00  0.00
            255.00  213.00  0.00
            255.00  212.00  0.00
            255.00  208.75  0.00
            255.00  205.50  0.00
            255.00  202.25  0.00
            255.00  199.00  0.00
            255.00  197.00  0.00
            255.00  195.00  0.00
            255.00  193.00  0.00
            255.00  191.00  0.00
            255.00  190.00  0.00
            255.00  189.00  0.00
            255.00  188.00  0.00
            255.00  187.00  0.00
            255.00  184.75  0.00
            255.00  182.50  0.00
            255.00  180.25  0.00
            255.00  178.00  0.00
            255.00  177.00  0.00
            255.00  176.00  0.00
            255.00  175.00  0.00
            255.00  174.00  0.00
            255.00  173.00  0.00
            255.00  172.00  0.00
            255.00  171.00  0.00
            255.00  170.00  0.00
            255.00  168.75  0.00
            255.00  167.50  0.00
            255.00  166.25  0.00
            255.00  165.00  0.00
            255.00  164.00  0.00
            255.00  163.00  0.00
            255.00  162.00  0.00
            255.00  161.00  0.00
            255.00  159.00  0.00
            255.00  157.00  0.00
            255.00  155.00  0.00
            255.00  153.00  0.00
            255.00  151.75  0.00
            255.00  150.50  0.00
            255.00  149.25  0.00
            255.00  148.00  0.00
            255.00  147.00  0.00
            255.00  146.00  0.00
            255.00  145.00  0.00
            255.00  144.00  0.00
            255.00  140.75  0.00
            255.00  137.50  0.00
            255.00  134.25  0.00
            255.00  131.00  0.00
            255.00  130.00  0.00
            255.00  129.00  0.00
            255.00  128.00  0.00
            255.00  127.00  0.00
            255.00  125.00  0.00
            255.00  123.00  0.00
            255.00  121.00  0.00
            255.00  119.00  0.00
            255.00  116.75  0.00
            255.00  114.50  0.00
            255.00  112.25  0.00
            255.00  110.00  0.00
            255.00  109.00  0.00
            255.00  108.00  0.00
            255.00  107.00  0.00
            255.00  106.00  0.00
            255.00  105.00  0.00
            255.00  104.00  0.00
            255.00  103.00  0.00
            255.00  102.00  0.00
            255.00  100.75  0.00
            255.00  99.50   0.00
            255.00  98.25   0.00
            255.00  97.00   0.00
            255.00  95.00   0.00
            255.00  93.00   0.00
            255.00  91.00   0.00
            255.00  89.00   0.00
            255.00  88.00   0.00
            255.00  87.00   0.00
            255.00  86.00   0.00
            255.00  85.00   0.00
            255.00  83.75   0.00
            255.00  82.50   0.00
            255.00  81.25   0.00
            255.00  80.00   0.00
            255.00  79.00   0.00
            255.00  78.00   0.00
            255.00  77.00   0.00
            255.00  76.00   0.00
            255.00  72.75   0.00
            255.00  69.50   0.00
            255.00  66.25   0.00
            255.00  63.00   0.00
            255.00  62.00   0.00
            255.00  61.00   0.00
            255.00  60.00   0.00
            255.00  59.00   0.00
            255.00  58.00   0.00
            255.00  57.00   0.00
            255.00  56.00   0.00
            255.00  55.00   0.00
            255.00  54.00   0.00
            255.00  53.00   0.00
            255.00  52.00   0.00
            255.00  51.00   0.00
            255.00  47.75   0.00
            255.00  44.50   0.00
            255.00  41.25   0.00
            255.00  38.00   0.00
            255.00  37.00   0.00
            255.00  36.00   0.00
            255.00  35.00   0.00
            255.00  34.00   0.00
            255.00  32.75   0.00
            255.00  31.50   0.00
            255.00  30.25   0.00
            255.00  29.00   0.00
            255.00  27.00   0.00
            255.00  25.00   0.00
            255.00  23.00   0.00
            255.00  21.00   0.00
            255.00  20.00   0.00
            255.00  19.00   0.00
            255.00  18.00   0.00
            255.00  17.00   0.00
            255.00  15.75   0.00
            255.00  14.50   0.00
            255.00  13.25   0.00
            255.00  12.00   0.00
            255.00  9.00    0.00
            255.00  6.00    0.00
            255.00  3.00    0.00
            255.00  0.00    0.00 ];
end
