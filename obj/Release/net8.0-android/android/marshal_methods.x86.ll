; ModuleID = 'marshal_methods.x86.ll'
source_filename = "marshal_methods.x86.ll"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i686-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [143 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [286 x i32] [
	i32 39109920, ; 0: Newtonsoft.Json.dll => 0x254c520 => 52
	i32 42639949, ; 1: System.Threading.Thread => 0x28aa24d => 132
	i32 67008169, ; 2: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 33
	i32 72070932, ; 3: Microsoft.Maui.Graphics.dll => 0x44bb714 => 50
	i32 117431740, ; 4: System.Runtime.InteropServices => 0x6ffddbc => 123
	i32 165246403, ; 5: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 64
	i32 182336117, ; 6: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 82
	i32 195452805, ; 7: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 30
	i32 199333315, ; 8: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 31
	i32 205061960, ; 9: System.ComponentModel => 0xc38ff48 => 100
	i32 230752869, ; 10: Microsoft.CSharp.dll => 0xdc10265 => 93
	i32 234507812, ; 11: Projekt_c4.dll => 0xdfa4e24 => 92
	i32 246610117, ; 12: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 121
	i32 280992041, ; 13: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 2
	i32 317674968, ; 14: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 30
	i32 318968648, ; 15: Xamarin.AndroidX.Activity.dll => 0x13031348 => 60
	i32 336156722, ; 16: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 15
	i32 342366114, ; 17: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 71
	i32 356389973, ; 18: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 14
	i32 379916513, ; 19: System.Threading.Thread.dll => 0x16a510e1 => 132
	i32 385762202, ; 20: System.Memory.dll => 0x16fe439a => 111
	i32 393699800, ; 21: Firebase => 0x177761d8 => 35
	i32 395744057, ; 22: _Microsoft.Android.Resource.Designer => 0x17969339 => 34
	i32 435591531, ; 23: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 26
	i32 442565967, ; 24: System.Collections => 0x1a61054f => 97
	i32 450948140, ; 25: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 70
	i32 459347974, ; 26: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 127
	i32 469710990, ; 27: System.dll => 0x1bff388e => 137
	i32 498788369, ; 28: System.ObjectModel => 0x1dbae811 => 116
	i32 500358224, ; 29: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 13
	i32 503918385, ; 30: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 7
	i32 513247710, ; 31: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 44
	i32 539058512, ; 32: Microsoft.Extensions.Logging => 0x20216150 => 41
	i32 592146354, ; 33: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 21
	i32 610194910, ; 34: System.Reactive.dll => 0x245ed5de => 57
	i32 627609679, ; 35: Xamarin.AndroidX.CustomView => 0x2568904f => 68
	i32 627931235, ; 36: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 19
	i32 662205335, ; 37: System.Text.Encodings.Web.dll => 0x27787397 => 58
	i32 672442732, ; 38: System.Collections.Concurrent => 0x2814a96c => 94
	i32 688181140, ; 39: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 1
	i32 690569205, ; 40: System.Xml.Linq.dll => 0x29293ff5 => 134
	i32 706645707, ; 41: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 16
	i32 709557578, ; 42: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 4
	i32 722857257, ; 43: System.Runtime.Loader.dll => 0x2b15ed29 => 124
	i32 759454413, ; 44: System.Net.Requests => 0x2d445acd => 114
	i32 775507847, ; 45: System.IO.Compression => 0x2e394f87 => 108
	i32 777317022, ; 46: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 25
	i32 789151979, ; 47: Microsoft.Extensions.Options => 0x2f0980eb => 43
	i32 804715423, ; 48: System.Data.Common => 0x2ff6fb9f => 102
	i32 823281589, ; 49: System.Private.Uri.dll => 0x311247b5 => 117
	i32 830298997, ; 50: System.IO.Compression.Brotli => 0x317d5b75 => 107
	i32 904024072, ; 51: System.ComponentModel.Primitives.dll => 0x35e25008 => 98
	i32 908888060, ; 52: Microsoft.Maui.Maps => 0x362c87fc => 51
	i32 926902833, ; 53: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 28
	i32 955402788, ; 54: Newtonsoft.Json => 0x38f24a24 => 52
	i32 967690846, ; 55: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 71
	i32 975874589, ; 56: System.Xml.XDocument => 0x3a2aaa1d => 136
	i32 992768348, ; 57: System.Collections.dll => 0x3b2c715c => 97
	i32 1012816738, ; 58: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 81
	i32 1019214401, ; 59: System.Drawing => 0x3cbffa41 => 106
	i32 1028951442, ; 60: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 40
	i32 1029334545, ; 61: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 3
	i32 1035644815, ; 62: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 61
	i32 1036536393, ; 63: System.Drawing.Primitives.dll => 0x3dc84a49 => 105
	i32 1044663988, ; 64: System.Linq.Expressions.dll => 0x3e444eb4 => 109
	i32 1052210849, ; 65: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 73
	i32 1082857460, ; 66: System.ComponentModel.TypeConverter => 0x408b17f4 => 99
	i32 1084122840, ; 67: Xamarin.Kotlin.StdLib => 0x409e66d8 => 90
	i32 1098259244, ; 68: System => 0x41761b2c => 137
	i32 1118262833, ; 69: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 16
	i32 1168523401, ; 70: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 22
	i32 1178241025, ; 71: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 78
	i32 1203215381, ; 72: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 20
	i32 1234928153, ; 73: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 18
	i32 1260983243, ; 74: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 2
	i32 1292207520, ; 75: SQLitePCLRaw.core.dll => 0x4d0585a0 => 54
	i32 1293217323, ; 76: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 69
	i32 1324164729, ; 77: System.Linq => 0x4eed2679 => 110
	i32 1373134921, ; 78: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 32
	i32 1376866003, ; 79: Xamarin.AndroidX.SavedState => 0x52114ed3 => 81
	i32 1406073936, ; 80: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 65
	i32 1408764838, ; 81: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 126
	i32 1430672901, ; 82: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 0
	i32 1461004990, ; 83: es\Microsoft.Maui.Controls.resources => 0x57152abe => 6
	i32 1462112819, ; 84: System.IO.Compression.dll => 0x57261233 => 108
	i32 1469204771, ; 85: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 62
	i32 1470490898, ; 86: Microsoft.Extensions.Primitives => 0x57a5e912 => 44
	i32 1480492111, ; 87: System.IO.Compression.Brotli.dll => 0x583e844f => 107
	i32 1493001747, ; 88: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 10
	i32 1514721132, ; 89: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 5
	i32 1543031311, ; 90: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 131
	i32 1551623176, ; 91: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 25
	i32 1622152042, ; 92: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 75
	i32 1624863272, ; 93: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 84
	i32 1636350590, ; 94: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 67
	i32 1639515021, ; 95: System.Net.Http.dll => 0x61b9038d => 112
	i32 1639986890, ; 96: System.Text.RegularExpressions => 0x61c036ca => 131
	i32 1657153582, ; 97: System.Runtime => 0x62c6282e => 128
	i32 1658251792, ; 98: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 85
	i32 1677501392, ; 99: System.Net.Primitives.dll => 0x63fca3d0 => 113
	i32 1679769178, ; 100: System.Security.Cryptography => 0x641f3e5a => 129
	i32 1729485958, ; 101: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 63
	i32 1736233607, ; 102: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 23
	i32 1743415430, ; 103: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 1
	i32 1746115085, ; 104: System.IO.Pipelines.dll => 0x68139a0d => 56
	i32 1763938596, ; 105: System.Diagnostics.TraceSource.dll => 0x69239124 => 104
	i32 1766324549, ; 106: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 82
	i32 1770582343, ; 107: Microsoft.Extensions.Logging.dll => 0x6988f147 => 41
	i32 1780572499, ; 108: Mono.Android.Runtime.dll => 0x6a216153 => 141
	i32 1782862114, ; 109: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 17
	i32 1788241197, ; 110: Xamarin.AndroidX.Fragment => 0x6a96652d => 70
	i32 1793755602, ; 111: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 9
	i32 1808609942, ; 112: Xamarin.AndroidX.Loader => 0x6bcd3296 => 75
	i32 1813058853, ; 113: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 90
	i32 1813201214, ; 114: Xamarin.Google.Android.Material => 0x6c13413e => 85
	i32 1818569960, ; 115: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 79
	i32 1824175904, ; 116: System.Text.Encoding.Extensions => 0x6cbab720 => 130
	i32 1824722060, ; 117: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 126
	i32 1828688058, ; 118: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 42
	i32 1842015223, ; 119: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 29
	i32 1853025655, ; 120: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 26
	i32 1858542181, ; 121: System.Linq.Expressions => 0x6ec71a65 => 109
	i32 1870277092, ; 122: System.Reflection.Primitives => 0x6f7a29e4 => 122
	i32 1875935024, ; 123: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 8
	i32 1908813208, ; 124: Xamarin.GooglePlayServices.Basement => 0x71c62d98 => 87
	i32 1910275211, ; 125: System.Collections.NonGeneric.dll => 0x71dc7c8b => 95
	i32 1939592360, ; 126: System.Private.Xml.Linq => 0x739bd4a8 => 118
	i32 1968388702, ; 127: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 37
	i32 2003115576, ; 128: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 5
	i32 2019465201, ; 129: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 73
	i32 2025202353, ; 130: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 0
	i32 2045470958, ; 131: System.Private.Xml => 0x79eb68ee => 119
	i32 2055257422, ; 132: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 72
	i32 2066184531, ; 133: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 4
	i32 2070888862, ; 134: System.Diagnostics.TraceSource => 0x7b6f419e => 104
	i32 2079903147, ; 135: System.Runtime.dll => 0x7bf8cdab => 128
	i32 2090596640, ; 136: System.Numerics.Vectors => 0x7c9bf920 => 115
	i32 2103459038, ; 137: SQLitePCLRaw.provider.e_sqlite3.dll => 0x7d603cde => 55
	i32 2127167465, ; 138: System.Console => 0x7ec9ffe9 => 101
	i32 2129483829, ; 139: Xamarin.GooglePlayServices.Base.dll => 0x7eed5835 => 86
	i32 2142473426, ; 140: System.Collections.Specialized => 0x7fb38cd2 => 96
	i32 2159891885, ; 141: Microsoft.Maui => 0x80bd55ad => 48
	i32 2169148018, ; 142: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 12
	i32 2181898931, ; 143: Microsoft.Extensions.Options.dll => 0x820d22b3 => 43
	i32 2192057212, ; 144: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 42
	i32 2193016926, ; 145: System.ObjectModel.dll => 0x82b6c85e => 116
	i32 2201107256, ; 146: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 91
	i32 2201231467, ; 147: System.Net.Http => 0x8334206b => 112
	i32 2207618523, ; 148: it\Microsoft.Maui.Controls.resources => 0x839595db => 14
	i32 2266799131, ; 149: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 38
	i32 2270573516, ; 150: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 8
	i32 2279755925, ; 151: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 80
	i32 2303073227, ; 152: Microsoft.Maui.Controls.Maps.dll => 0x89461bcb => 46
	i32 2303942373, ; 153: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 18
	i32 2305521784, ; 154: System.Private.CoreLib.dll => 0x896b7878 => 139
	i32 2353062107, ; 155: System.Net.Primitives => 0x8c40e0db => 113
	i32 2368005991, ; 156: System.Xml.ReaderWriter.dll => 0x8d24e767 => 135
	i32 2371007202, ; 157: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 37
	i32 2395872292, ; 158: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 13
	i32 2427813419, ; 159: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 10
	i32 2435356389, ; 160: System.Console.dll => 0x912896e5 => 101
	i32 2471841756, ; 161: netstandard.dll => 0x93554fdc => 138
	i32 2475788418, ; 162: Java.Interop.dll => 0x93918882 => 140
	i32 2480646305, ; 163: Microsoft.Maui.Controls => 0x93dba8a1 => 45
	i32 2538310050, ; 164: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 121
	i32 2550873716, ; 165: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 11
	i32 2562349572, ; 166: Microsoft.CSharp => 0x98ba5a04 => 93
	i32 2570120770, ; 167: System.Text.Encodings.Web => 0x9930ee42 => 58
	i32 2585220780, ; 168: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 130
	i32 2593496499, ; 169: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 20
	i32 2605712449, ; 170: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 91
	i32 2617129537, ; 171: System.Private.Xml.dll => 0x9bfe3a41 => 119
	i32 2620871830, ; 172: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 67
	i32 2626831493, ; 173: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 15
	i32 2663698177, ; 174: System.Runtime.Loader => 0x9ec4cf01 => 124
	i32 2664396074, ; 175: System.Xml.XDocument.dll => 0x9ecf752a => 136
	i32 2665622720, ; 176: System.Drawing.Primitives => 0x9ee22cc0 => 105
	i32 2676780864, ; 177: System.Data.Common.dll => 0x9f8c6f40 => 102
	i32 2724373263, ; 178: System.Runtime.Numerics.dll => 0xa262a30f => 125
	i32 2732626843, ; 179: Xamarin.AndroidX.Activity => 0xa2e0939b => 60
	i32 2737747696, ; 180: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 62
	i32 2752995522, ; 181: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 21
	i32 2758225723, ; 182: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 47
	i32 2764765095, ; 183: Microsoft.Maui.dll => 0xa4caf7a7 => 48
	i32 2778768386, ; 184: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 83
	i32 2785988530, ; 185: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 27
	i32 2801831435, ; 186: Microsoft.Maui.Graphics => 0xa7008e0b => 50
	i32 2806116107, ; 187: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 6
	i32 2810250172, ; 188: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 65
	i32 2831556043, ; 189: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 19
	i32 2847418871, ; 190: Xamarin.GooglePlayServices.Base => 0xa9b829f7 => 86
	i32 2853208004, ; 191: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 83
	i32 2861189240, ; 192: Microsoft.Maui.Essentials => 0xaa8a4878 => 49
	i32 2900489095, ; 193: Projekt_c4 => 0xace1f387 => 92
	i32 2909740682, ; 194: System.Private.CoreLib => 0xad6f1e8a => 139
	i32 2916838712, ; 195: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 84
	i32 2919462931, ; 196: System.Numerics.Vectors.dll => 0xae037813 => 115
	i32 2959614098, ; 197: System.ComponentModel.dll => 0xb0682092 => 100
	i32 2978675010, ; 198: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 69
	i32 3017076677, ; 199: Xamarin.GooglePlayServices.Maps => 0xb3d4efc5 => 88
	i32 3038032645, ; 200: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 34
	i32 3057625584, ; 201: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 76
	i32 3058099980, ; 202: Xamarin.GooglePlayServices.Tasks => 0xb646e70c => 89
	i32 3059408633, ; 203: Mono.Android.Runtime => 0xb65adef9 => 141
	i32 3059793426, ; 204: System.ComponentModel.Primitives => 0xb660be12 => 98
	i32 3077302341, ; 205: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 12
	i32 3159123045, ; 206: System.Reflection.Primitives.dll => 0xbc4c6465 => 122
	i32 3178803400, ; 207: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 77
	i32 3220365878, ; 208: System.Threading => 0xbff2e236 => 133
	i32 3230466174, ; 209: Xamarin.GooglePlayServices.Basement.dll => 0xc08d007e => 87
	i32 3258312781, ; 210: Xamarin.AndroidX.CardView => 0xc235e84d => 63
	i32 3286872994, ; 211: SQLite-net.dll => 0xc3e9b3a2 => 53
	i32 3305363605, ; 212: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 7
	i32 3316684772, ; 213: System.Net.Requests.dll => 0xc5b097e4 => 114
	i32 3317135071, ; 214: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 68
	i32 3322403133, ; 215: Firebase.dll => 0xc607d93d => 35
	i32 3346324047, ; 216: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 78
	i32 3357674450, ; 217: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 24
	i32 3358260929, ; 218: System.Text.Json => 0xc82afec1 => 59
	i32 3360279109, ; 219: SQLitePCLRaw.core => 0xc849ca45 => 54
	i32 3362522851, ; 220: Xamarin.AndroidX.Core => 0xc86c06e3 => 66
	i32 3366347497, ; 221: Java.Interop => 0xc8a662e9 => 140
	i32 3374999561, ; 222: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 80
	i32 3381016424, ; 223: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 3
	i32 3428513518, ; 224: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 39
	i32 3430777524, ; 225: netstandard => 0xcc7d82b4 => 138
	i32 3463511458, ; 226: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 11
	i32 3471940407, ; 227: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 99
	i32 3476120550, ; 228: Mono.Android => 0xcf3163e6 => 142
	i32 3479583265, ; 229: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 24
	i32 3484440000, ; 230: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 23
	i32 3485117614, ; 231: System.Text.Json.dll => 0xcfbaacae => 59
	i32 3500773090, ; 232: Microsoft.Maui.Controls.Maps => 0xd0a98ee2 => 46
	i32 3509114376, ; 233: System.Xml.Linq => 0xd128d608 => 134
	i32 3580758918, ; 234: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 31
	i32 3596207933, ; 235: LiteDB.dll => 0xd659c73d => 36
	i32 3608519521, ; 236: System.Linq.dll => 0xd715a361 => 110
	i32 3629588173, ; 237: LiteDB => 0xd8571ecd => 36
	i32 3641597786, ; 238: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 72
	i32 3643446276, ; 239: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 28
	i32 3643854240, ; 240: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 77
	i32 3657292374, ; 241: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 38
	i32 3672681054, ; 242: Mono.Android.dll => 0xdae8aa5e => 142
	i32 3697841164, ; 243: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 33
	i32 3724971120, ; 244: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 76
	i32 3731644420, ; 245: System.Reactive => 0xde6c6004 => 57
	i32 3748608112, ; 246: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 103
	i32 3754567612, ; 247: SQLitePCLRaw.provider.e_sqlite3 => 0xdfca27bc => 55
	i32 3786282454, ; 248: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 64
	i32 3792276235, ; 249: System.Collections.NonGeneric => 0xe2098b0b => 95
	i32 3802395368, ; 250: System.Collections.Specialized.dll => 0xe2a3f2e8 => 96
	i32 3823082795, ; 251: System.Security.Cryptography.dll => 0xe3df9d2b => 129
	i32 3841636137, ; 252: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 40
	i32 3849253459, ; 253: System.Runtime.InteropServices.dll => 0xe56ef253 => 123
	i32 3876362041, ; 254: SQLite-net => 0xe70c9739 => 53
	i32 3889960447, ; 255: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 32
	i32 3896106733, ; 256: System.Collections.Concurrent.dll => 0xe839deed => 94
	i32 3896760992, ; 257: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 66
	i32 3928044579, ; 258: System.Xml.ReaderWriter => 0xea213423 => 135
	i32 3931092270, ; 259: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 79
	i32 3955647286, ; 260: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 61
	i32 3970018735, ; 261: Xamarin.GooglePlayServices.Tasks.dll => 0xeca1adaf => 89
	i32 3980434154, ; 262: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 27
	i32 3987592930, ; 263: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 9
	i32 4023392905, ; 264: System.IO.Pipelines => 0xefd01a89 => 56
	i32 4025784931, ; 265: System.Memory => 0xeff49a63 => 111
	i32 4046471985, ; 266: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 47
	i32 4054681211, ; 267: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 120
	i32 4068434129, ; 268: System.Private.Xml.Linq.dll => 0xf27f60d1 => 118
	i32 4073602200, ; 269: System.Threading.dll => 0xf2ce3c98 => 133
	i32 4094352644, ; 270: Microsoft.Maui.Essentials.dll => 0xf40add04 => 49
	i32 4099507663, ; 271: System.Drawing.dll => 0xf45985cf => 106
	i32 4100113165, ; 272: System.Private.Uri => 0xf462c30d => 117
	i32 4102112229, ; 273: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 22
	i32 4125707920, ; 274: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 17
	i32 4126470640, ; 275: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 39
	i32 4147896353, ; 276: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 120
	i32 4150914736, ; 277: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 29
	i32 4181436372, ; 278: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 127
	i32 4182413190, ; 279: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 74
	i32 4190991637, ; 280: Microsoft.Maui.Maps.dll => 0xf9cd7515 => 51
	i32 4213026141, ; 281: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 103
	i32 4271975918, ; 282: Microsoft.Maui.Controls.dll => 0xfea12dee => 45
	i32 4274976490, ; 283: System.Runtime.Numerics => 0xfecef6ea => 125
	i32 4278134329, ; 284: Xamarin.GooglePlayServices.Maps.dll => 0xfeff2639 => 88
	i32 4292120959 ; 285: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 74
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [286 x i32] [
	i32 52, ; 0
	i32 132, ; 1
	i32 33, ; 2
	i32 50, ; 3
	i32 123, ; 4
	i32 64, ; 5
	i32 82, ; 6
	i32 30, ; 7
	i32 31, ; 8
	i32 100, ; 9
	i32 93, ; 10
	i32 92, ; 11
	i32 121, ; 12
	i32 2, ; 13
	i32 30, ; 14
	i32 60, ; 15
	i32 15, ; 16
	i32 71, ; 17
	i32 14, ; 18
	i32 132, ; 19
	i32 111, ; 20
	i32 35, ; 21
	i32 34, ; 22
	i32 26, ; 23
	i32 97, ; 24
	i32 70, ; 25
	i32 127, ; 26
	i32 137, ; 27
	i32 116, ; 28
	i32 13, ; 29
	i32 7, ; 30
	i32 44, ; 31
	i32 41, ; 32
	i32 21, ; 33
	i32 57, ; 34
	i32 68, ; 35
	i32 19, ; 36
	i32 58, ; 37
	i32 94, ; 38
	i32 1, ; 39
	i32 134, ; 40
	i32 16, ; 41
	i32 4, ; 42
	i32 124, ; 43
	i32 114, ; 44
	i32 108, ; 45
	i32 25, ; 46
	i32 43, ; 47
	i32 102, ; 48
	i32 117, ; 49
	i32 107, ; 50
	i32 98, ; 51
	i32 51, ; 52
	i32 28, ; 53
	i32 52, ; 54
	i32 71, ; 55
	i32 136, ; 56
	i32 97, ; 57
	i32 81, ; 58
	i32 106, ; 59
	i32 40, ; 60
	i32 3, ; 61
	i32 61, ; 62
	i32 105, ; 63
	i32 109, ; 64
	i32 73, ; 65
	i32 99, ; 66
	i32 90, ; 67
	i32 137, ; 68
	i32 16, ; 69
	i32 22, ; 70
	i32 78, ; 71
	i32 20, ; 72
	i32 18, ; 73
	i32 2, ; 74
	i32 54, ; 75
	i32 69, ; 76
	i32 110, ; 77
	i32 32, ; 78
	i32 81, ; 79
	i32 65, ; 80
	i32 126, ; 81
	i32 0, ; 82
	i32 6, ; 83
	i32 108, ; 84
	i32 62, ; 85
	i32 44, ; 86
	i32 107, ; 87
	i32 10, ; 88
	i32 5, ; 89
	i32 131, ; 90
	i32 25, ; 91
	i32 75, ; 92
	i32 84, ; 93
	i32 67, ; 94
	i32 112, ; 95
	i32 131, ; 96
	i32 128, ; 97
	i32 85, ; 98
	i32 113, ; 99
	i32 129, ; 100
	i32 63, ; 101
	i32 23, ; 102
	i32 1, ; 103
	i32 56, ; 104
	i32 104, ; 105
	i32 82, ; 106
	i32 41, ; 107
	i32 141, ; 108
	i32 17, ; 109
	i32 70, ; 110
	i32 9, ; 111
	i32 75, ; 112
	i32 90, ; 113
	i32 85, ; 114
	i32 79, ; 115
	i32 130, ; 116
	i32 126, ; 117
	i32 42, ; 118
	i32 29, ; 119
	i32 26, ; 120
	i32 109, ; 121
	i32 122, ; 122
	i32 8, ; 123
	i32 87, ; 124
	i32 95, ; 125
	i32 118, ; 126
	i32 37, ; 127
	i32 5, ; 128
	i32 73, ; 129
	i32 0, ; 130
	i32 119, ; 131
	i32 72, ; 132
	i32 4, ; 133
	i32 104, ; 134
	i32 128, ; 135
	i32 115, ; 136
	i32 55, ; 137
	i32 101, ; 138
	i32 86, ; 139
	i32 96, ; 140
	i32 48, ; 141
	i32 12, ; 142
	i32 43, ; 143
	i32 42, ; 144
	i32 116, ; 145
	i32 91, ; 146
	i32 112, ; 147
	i32 14, ; 148
	i32 38, ; 149
	i32 8, ; 150
	i32 80, ; 151
	i32 46, ; 152
	i32 18, ; 153
	i32 139, ; 154
	i32 113, ; 155
	i32 135, ; 156
	i32 37, ; 157
	i32 13, ; 158
	i32 10, ; 159
	i32 101, ; 160
	i32 138, ; 161
	i32 140, ; 162
	i32 45, ; 163
	i32 121, ; 164
	i32 11, ; 165
	i32 93, ; 166
	i32 58, ; 167
	i32 130, ; 168
	i32 20, ; 169
	i32 91, ; 170
	i32 119, ; 171
	i32 67, ; 172
	i32 15, ; 173
	i32 124, ; 174
	i32 136, ; 175
	i32 105, ; 176
	i32 102, ; 177
	i32 125, ; 178
	i32 60, ; 179
	i32 62, ; 180
	i32 21, ; 181
	i32 47, ; 182
	i32 48, ; 183
	i32 83, ; 184
	i32 27, ; 185
	i32 50, ; 186
	i32 6, ; 187
	i32 65, ; 188
	i32 19, ; 189
	i32 86, ; 190
	i32 83, ; 191
	i32 49, ; 192
	i32 92, ; 193
	i32 139, ; 194
	i32 84, ; 195
	i32 115, ; 196
	i32 100, ; 197
	i32 69, ; 198
	i32 88, ; 199
	i32 34, ; 200
	i32 76, ; 201
	i32 89, ; 202
	i32 141, ; 203
	i32 98, ; 204
	i32 12, ; 205
	i32 122, ; 206
	i32 77, ; 207
	i32 133, ; 208
	i32 87, ; 209
	i32 63, ; 210
	i32 53, ; 211
	i32 7, ; 212
	i32 114, ; 213
	i32 68, ; 214
	i32 35, ; 215
	i32 78, ; 216
	i32 24, ; 217
	i32 59, ; 218
	i32 54, ; 219
	i32 66, ; 220
	i32 140, ; 221
	i32 80, ; 222
	i32 3, ; 223
	i32 39, ; 224
	i32 138, ; 225
	i32 11, ; 226
	i32 99, ; 227
	i32 142, ; 228
	i32 24, ; 229
	i32 23, ; 230
	i32 59, ; 231
	i32 46, ; 232
	i32 134, ; 233
	i32 31, ; 234
	i32 36, ; 235
	i32 110, ; 236
	i32 36, ; 237
	i32 72, ; 238
	i32 28, ; 239
	i32 77, ; 240
	i32 38, ; 241
	i32 142, ; 242
	i32 33, ; 243
	i32 76, ; 244
	i32 57, ; 245
	i32 103, ; 246
	i32 55, ; 247
	i32 64, ; 248
	i32 95, ; 249
	i32 96, ; 250
	i32 129, ; 251
	i32 40, ; 252
	i32 123, ; 253
	i32 53, ; 254
	i32 32, ; 255
	i32 94, ; 256
	i32 66, ; 257
	i32 135, ; 258
	i32 79, ; 259
	i32 61, ; 260
	i32 89, ; 261
	i32 27, ; 262
	i32 9, ; 263
	i32 56, ; 264
	i32 111, ; 265
	i32 47, ; 266
	i32 120, ; 267
	i32 118, ; 268
	i32 133, ; 269
	i32 49, ; 270
	i32 106, ; 271
	i32 117, ; 272
	i32 22, ; 273
	i32 17, ; 274
	i32 39, ; 275
	i32 120, ; 276
	i32 29, ; 277
	i32 127, ; 278
	i32 74, ; 279
	i32 51, ; 280
	i32 103, ; 281
	i32 45, ; 282
	i32 125, ; 283
	i32 88, ; 284
	i32 74 ; 285
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ 82d8938cf80f6d5fa6c28529ddfbdb753d805ab4"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"NumRegisterParameters", i32 0}
