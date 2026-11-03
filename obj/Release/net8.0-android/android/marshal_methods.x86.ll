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

@assembly_image_cache = dso_local local_unnamed_addr global [122 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [244 x i32] [
	i32 42639949, ; 0: System.Threading.Thread => 0x28aa24d => 114
	i32 67008169, ; 1: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 33
	i32 72070932, ; 2: Microsoft.Maui.Graphics.dll => 0x44bb714 => 48
	i32 117431740, ; 3: System.Runtime.InteropServices => 0x6ffddbc => 109
	i32 165246403, ; 4: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 60
	i32 182336117, ; 5: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 78
	i32 195452805, ; 6: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 30
	i32 199333315, ; 7: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 31
	i32 205061960, ; 8: System.ComponentModel => 0xc38ff48 => 94
	i32 234507812, ; 9: Projekt_c4.dll => 0xdfa4e24 => 88
	i32 280992041, ; 10: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 2
	i32 317674968, ; 11: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 30
	i32 318968648, ; 12: Xamarin.AndroidX.Activity.dll => 0x13031348 => 56
	i32 336156722, ; 13: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 15
	i32 342366114, ; 14: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 67
	i32 356389973, ; 15: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 14
	i32 379916513, ; 16: System.Threading.Thread.dll => 0x16a510e1 => 114
	i32 385762202, ; 17: System.Memory.dll => 0x16fe439a => 101
	i32 395744057, ; 18: _Microsoft.Android.Resource.Designer => 0x17969339 => 34
	i32 435591531, ; 19: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 26
	i32 442565967, ; 20: System.Collections => 0x1a61054f => 91
	i32 450948140, ; 21: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 66
	i32 469710990, ; 22: System.dll => 0x1bff388e => 117
	i32 498788369, ; 23: System.ObjectModel => 0x1dbae811 => 106
	i32 500358224, ; 24: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 13
	i32 503918385, ; 25: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 7
	i32 513247710, ; 26: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 42
	i32 539058512, ; 27: Microsoft.Extensions.Logging => 0x20216150 => 39
	i32 592146354, ; 28: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 21
	i32 627609679, ; 29: Xamarin.AndroidX.CustomView => 0x2568904f => 64
	i32 627931235, ; 30: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 19
	i32 662205335, ; 31: System.Text.Encodings.Web.dll => 0x27787397 => 54
	i32 672442732, ; 32: System.Collections.Concurrent => 0x2814a96c => 89
	i32 688181140, ; 33: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 1
	i32 706645707, ; 34: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 16
	i32 709557578, ; 35: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 4
	i32 722857257, ; 36: System.Runtime.Loader.dll => 0x2b15ed29 => 110
	i32 759454413, ; 37: System.Net.Requests => 0x2d445acd => 104
	i32 775507847, ; 38: System.IO.Compression => 0x2e394f87 => 98
	i32 777317022, ; 39: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 25
	i32 789151979, ; 40: Microsoft.Extensions.Options => 0x2f0980eb => 41
	i32 823281589, ; 41: System.Private.Uri.dll => 0x311247b5 => 107
	i32 830298997, ; 42: System.IO.Compression.Brotli => 0x317d5b75 => 97
	i32 904024072, ; 43: System.ComponentModel.Primitives.dll => 0x35e25008 => 92
	i32 908888060, ; 44: Microsoft.Maui.Maps => 0x362c87fc => 49
	i32 926902833, ; 45: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 28
	i32 967690846, ; 46: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 67
	i32 992768348, ; 47: System.Collections.dll => 0x3b2c715c => 91
	i32 1012816738, ; 48: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 77
	i32 1028951442, ; 49: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 38
	i32 1029334545, ; 50: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 3
	i32 1035644815, ; 51: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 57
	i32 1044663988, ; 52: System.Linq.Expressions.dll => 0x3e444eb4 => 99
	i32 1052210849, ; 53: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 69
	i32 1082857460, ; 54: System.ComponentModel.TypeConverter => 0x408b17f4 => 93
	i32 1084122840, ; 55: Xamarin.Kotlin.StdLib => 0x409e66d8 => 86
	i32 1098259244, ; 56: System => 0x41761b2c => 117
	i32 1118262833, ; 57: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 16
	i32 1168523401, ; 58: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 22
	i32 1178241025, ; 59: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 74
	i32 1203215381, ; 60: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 20
	i32 1234928153, ; 61: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 18
	i32 1260983243, ; 62: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 2
	i32 1292207520, ; 63: SQLitePCLRaw.core.dll => 0x4d0585a0 => 51
	i32 1293217323, ; 64: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 65
	i32 1324164729, ; 65: System.Linq => 0x4eed2679 => 100
	i32 1373134921, ; 66: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 32
	i32 1376866003, ; 67: Xamarin.AndroidX.SavedState => 0x52114ed3 => 77
	i32 1406073936, ; 68: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 61
	i32 1430672901, ; 69: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 0
	i32 1461004990, ; 70: es\Microsoft.Maui.Controls.resources => 0x57152abe => 6
	i32 1462112819, ; 71: System.IO.Compression.dll => 0x57261233 => 98
	i32 1469204771, ; 72: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 58
	i32 1470490898, ; 73: Microsoft.Extensions.Primitives => 0x57a5e912 => 42
	i32 1480492111, ; 74: System.IO.Compression.Brotli.dll => 0x583e844f => 97
	i32 1493001747, ; 75: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 10
	i32 1514721132, ; 76: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 5
	i32 1543031311, ; 77: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 113
	i32 1551623176, ; 78: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 25
	i32 1622152042, ; 79: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 71
	i32 1624863272, ; 80: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 80
	i32 1636350590, ; 81: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 63
	i32 1639515021, ; 82: System.Net.Http.dll => 0x61b9038d => 102
	i32 1639986890, ; 83: System.Text.RegularExpressions => 0x61c036ca => 113
	i32 1657153582, ; 84: System.Runtime => 0x62c6282e => 111
	i32 1658251792, ; 85: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 81
	i32 1677501392, ; 86: System.Net.Primitives.dll => 0x63fca3d0 => 103
	i32 1679769178, ; 87: System.Security.Cryptography => 0x641f3e5a => 112
	i32 1729485958, ; 88: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 59
	i32 1736233607, ; 89: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 23
	i32 1743415430, ; 90: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 1
	i32 1746115085, ; 91: System.IO.Pipelines.dll => 0x68139a0d => 53
	i32 1766324549, ; 92: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 78
	i32 1770582343, ; 93: Microsoft.Extensions.Logging.dll => 0x6988f147 => 39
	i32 1780572499, ; 94: Mono.Android.Runtime.dll => 0x6a216153 => 120
	i32 1782862114, ; 95: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 17
	i32 1788241197, ; 96: Xamarin.AndroidX.Fragment => 0x6a96652d => 66
	i32 1793755602, ; 97: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 9
	i32 1808609942, ; 98: Xamarin.AndroidX.Loader => 0x6bcd3296 => 71
	i32 1813058853, ; 99: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 86
	i32 1813201214, ; 100: Xamarin.Google.Android.Material => 0x6c13413e => 81
	i32 1818569960, ; 101: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 75
	i32 1828688058, ; 102: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 40
	i32 1842015223, ; 103: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 29
	i32 1853025655, ; 104: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 26
	i32 1858542181, ; 105: System.Linq.Expressions => 0x6ec71a65 => 99
	i32 1875935024, ; 106: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 8
	i32 1908813208, ; 107: Xamarin.GooglePlayServices.Basement => 0x71c62d98 => 83
	i32 1910275211, ; 108: System.Collections.NonGeneric.dll => 0x71dc7c8b => 90
	i32 1968388702, ; 109: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 35
	i32 2003115576, ; 110: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 5
	i32 2019465201, ; 111: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 69
	i32 2025202353, ; 112: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 0
	i32 2045470958, ; 113: System.Private.Xml => 0x79eb68ee => 108
	i32 2055257422, ; 114: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 68
	i32 2066184531, ; 115: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 4
	i32 2079903147, ; 116: System.Runtime.dll => 0x7bf8cdab => 111
	i32 2090596640, ; 117: System.Numerics.Vectors => 0x7c9bf920 => 105
	i32 2103459038, ; 118: SQLitePCLRaw.provider.e_sqlite3.dll => 0x7d603cde => 52
	i32 2127167465, ; 119: System.Console => 0x7ec9ffe9 => 95
	i32 2129483829, ; 120: Xamarin.GooglePlayServices.Base.dll => 0x7eed5835 => 82
	i32 2159891885, ; 121: Microsoft.Maui => 0x80bd55ad => 46
	i32 2169148018, ; 122: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 12
	i32 2181898931, ; 123: Microsoft.Extensions.Options.dll => 0x820d22b3 => 41
	i32 2192057212, ; 124: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 40
	i32 2193016926, ; 125: System.ObjectModel.dll => 0x82b6c85e => 106
	i32 2201107256, ; 126: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 87
	i32 2201231467, ; 127: System.Net.Http => 0x8334206b => 102
	i32 2207618523, ; 128: it\Microsoft.Maui.Controls.resources => 0x839595db => 14
	i32 2266799131, ; 129: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 36
	i32 2270573516, ; 130: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 8
	i32 2279755925, ; 131: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 76
	i32 2303073227, ; 132: Microsoft.Maui.Controls.Maps.dll => 0x89461bcb => 44
	i32 2303942373, ; 133: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 18
	i32 2305521784, ; 134: System.Private.CoreLib.dll => 0x896b7878 => 118
	i32 2353062107, ; 135: System.Net.Primitives => 0x8c40e0db => 103
	i32 2368005991, ; 136: System.Xml.ReaderWriter.dll => 0x8d24e767 => 116
	i32 2371007202, ; 137: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 35
	i32 2395872292, ; 138: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 13
	i32 2427813419, ; 139: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 10
	i32 2435356389, ; 140: System.Console.dll => 0x912896e5 => 95
	i32 2475788418, ; 141: Java.Interop.dll => 0x93918882 => 119
	i32 2480646305, ; 142: Microsoft.Maui.Controls => 0x93dba8a1 => 43
	i32 2550873716, ; 143: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 11
	i32 2570120770, ; 144: System.Text.Encodings.Web => 0x9930ee42 => 54
	i32 2593496499, ; 145: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 20
	i32 2605712449, ; 146: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 87
	i32 2617129537, ; 147: System.Private.Xml.dll => 0x9bfe3a41 => 108
	i32 2620871830, ; 148: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 63
	i32 2626831493, ; 149: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 15
	i32 2663698177, ; 150: System.Runtime.Loader => 0x9ec4cf01 => 110
	i32 2732626843, ; 151: Xamarin.AndroidX.Activity => 0xa2e0939b => 56
	i32 2737747696, ; 152: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 58
	i32 2752995522, ; 153: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 21
	i32 2758225723, ; 154: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 45
	i32 2764765095, ; 155: Microsoft.Maui.dll => 0xa4caf7a7 => 46
	i32 2778768386, ; 156: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 79
	i32 2785988530, ; 157: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 27
	i32 2801831435, ; 158: Microsoft.Maui.Graphics => 0xa7008e0b => 48
	i32 2806116107, ; 159: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 6
	i32 2810250172, ; 160: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 61
	i32 2831556043, ; 161: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 19
	i32 2847418871, ; 162: Xamarin.GooglePlayServices.Base => 0xa9b829f7 => 82
	i32 2853208004, ; 163: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 79
	i32 2861189240, ; 164: Microsoft.Maui.Essentials => 0xaa8a4878 => 47
	i32 2900489095, ; 165: Projekt_c4 => 0xace1f387 => 88
	i32 2909740682, ; 166: System.Private.CoreLib => 0xad6f1e8a => 118
	i32 2916838712, ; 167: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 80
	i32 2919462931, ; 168: System.Numerics.Vectors.dll => 0xae037813 => 105
	i32 2959614098, ; 169: System.ComponentModel.dll => 0xb0682092 => 94
	i32 2978675010, ; 170: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 65
	i32 3017076677, ; 171: Xamarin.GooglePlayServices.Maps => 0xb3d4efc5 => 84
	i32 3038032645, ; 172: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 34
	i32 3057625584, ; 173: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 72
	i32 3058099980, ; 174: Xamarin.GooglePlayServices.Tasks => 0xb646e70c => 85
	i32 3059408633, ; 175: Mono.Android.Runtime => 0xb65adef9 => 120
	i32 3059793426, ; 176: System.ComponentModel.Primitives => 0xb660be12 => 92
	i32 3077302341, ; 177: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 12
	i32 3178803400, ; 178: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 73
	i32 3220365878, ; 179: System.Threading => 0xbff2e236 => 115
	i32 3230466174, ; 180: Xamarin.GooglePlayServices.Basement.dll => 0xc08d007e => 83
	i32 3258312781, ; 181: Xamarin.AndroidX.CardView => 0xc235e84d => 59
	i32 3286872994, ; 182: SQLite-net.dll => 0xc3e9b3a2 => 50
	i32 3305363605, ; 183: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 7
	i32 3316684772, ; 184: System.Net.Requests.dll => 0xc5b097e4 => 104
	i32 3317135071, ; 185: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 64
	i32 3346324047, ; 186: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 74
	i32 3357674450, ; 187: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 24
	i32 3358260929, ; 188: System.Text.Json => 0xc82afec1 => 55
	i32 3360279109, ; 189: SQLitePCLRaw.core => 0xc849ca45 => 51
	i32 3362522851, ; 190: Xamarin.AndroidX.Core => 0xc86c06e3 => 62
	i32 3366347497, ; 191: Java.Interop => 0xc8a662e9 => 119
	i32 3374999561, ; 192: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 76
	i32 3381016424, ; 193: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 3
	i32 3428513518, ; 194: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 37
	i32 3463511458, ; 195: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 11
	i32 3471940407, ; 196: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 93
	i32 3476120550, ; 197: Mono.Android => 0xcf3163e6 => 121
	i32 3479583265, ; 198: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 24
	i32 3484440000, ; 199: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 23
	i32 3485117614, ; 200: System.Text.Json.dll => 0xcfbaacae => 55
	i32 3500773090, ; 201: Microsoft.Maui.Controls.Maps => 0xd0a98ee2 => 44
	i32 3580758918, ; 202: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 31
	i32 3608519521, ; 203: System.Linq.dll => 0xd715a361 => 100
	i32 3641597786, ; 204: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 68
	i32 3643446276, ; 205: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 28
	i32 3643854240, ; 206: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 73
	i32 3657292374, ; 207: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 36
	i32 3672681054, ; 208: Mono.Android.dll => 0xdae8aa5e => 121
	i32 3697841164, ; 209: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 33
	i32 3724971120, ; 210: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 72
	i32 3748608112, ; 211: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 96
	i32 3754567612, ; 212: SQLitePCLRaw.provider.e_sqlite3 => 0xdfca27bc => 52
	i32 3786282454, ; 213: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 60
	i32 3792276235, ; 214: System.Collections.NonGeneric => 0xe2098b0b => 90
	i32 3823082795, ; 215: System.Security.Cryptography.dll => 0xe3df9d2b => 112
	i32 3841636137, ; 216: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 38
	i32 3849253459, ; 217: System.Runtime.InteropServices.dll => 0xe56ef253 => 109
	i32 3876362041, ; 218: SQLite-net => 0xe70c9739 => 50
	i32 3889960447, ; 219: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 32
	i32 3896106733, ; 220: System.Collections.Concurrent.dll => 0xe839deed => 89
	i32 3896760992, ; 221: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 62
	i32 3928044579, ; 222: System.Xml.ReaderWriter => 0xea213423 => 116
	i32 3931092270, ; 223: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 75
	i32 3955647286, ; 224: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 57
	i32 3970018735, ; 225: Xamarin.GooglePlayServices.Tasks.dll => 0xeca1adaf => 85
	i32 3980434154, ; 226: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 27
	i32 3987592930, ; 227: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 9
	i32 4023392905, ; 228: System.IO.Pipelines => 0xefd01a89 => 53
	i32 4025784931, ; 229: System.Memory => 0xeff49a63 => 101
	i32 4046471985, ; 230: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 45
	i32 4073602200, ; 231: System.Threading.dll => 0xf2ce3c98 => 115
	i32 4094352644, ; 232: Microsoft.Maui.Essentials.dll => 0xf40add04 => 47
	i32 4100113165, ; 233: System.Private.Uri => 0xf462c30d => 107
	i32 4102112229, ; 234: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 22
	i32 4125707920, ; 235: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 17
	i32 4126470640, ; 236: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 37
	i32 4150914736, ; 237: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 29
	i32 4182413190, ; 238: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 70
	i32 4190991637, ; 239: Microsoft.Maui.Maps.dll => 0xf9cd7515 => 49
	i32 4213026141, ; 240: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 96
	i32 4271975918, ; 241: Microsoft.Maui.Controls.dll => 0xfea12dee => 43
	i32 4278134329, ; 242: Xamarin.GooglePlayServices.Maps.dll => 0xfeff2639 => 84
	i32 4292120959 ; 243: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 70
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [244 x i32] [
	i32 114, ; 0
	i32 33, ; 1
	i32 48, ; 2
	i32 109, ; 3
	i32 60, ; 4
	i32 78, ; 5
	i32 30, ; 6
	i32 31, ; 7
	i32 94, ; 8
	i32 88, ; 9
	i32 2, ; 10
	i32 30, ; 11
	i32 56, ; 12
	i32 15, ; 13
	i32 67, ; 14
	i32 14, ; 15
	i32 114, ; 16
	i32 101, ; 17
	i32 34, ; 18
	i32 26, ; 19
	i32 91, ; 20
	i32 66, ; 21
	i32 117, ; 22
	i32 106, ; 23
	i32 13, ; 24
	i32 7, ; 25
	i32 42, ; 26
	i32 39, ; 27
	i32 21, ; 28
	i32 64, ; 29
	i32 19, ; 30
	i32 54, ; 31
	i32 89, ; 32
	i32 1, ; 33
	i32 16, ; 34
	i32 4, ; 35
	i32 110, ; 36
	i32 104, ; 37
	i32 98, ; 38
	i32 25, ; 39
	i32 41, ; 40
	i32 107, ; 41
	i32 97, ; 42
	i32 92, ; 43
	i32 49, ; 44
	i32 28, ; 45
	i32 67, ; 46
	i32 91, ; 47
	i32 77, ; 48
	i32 38, ; 49
	i32 3, ; 50
	i32 57, ; 51
	i32 99, ; 52
	i32 69, ; 53
	i32 93, ; 54
	i32 86, ; 55
	i32 117, ; 56
	i32 16, ; 57
	i32 22, ; 58
	i32 74, ; 59
	i32 20, ; 60
	i32 18, ; 61
	i32 2, ; 62
	i32 51, ; 63
	i32 65, ; 64
	i32 100, ; 65
	i32 32, ; 66
	i32 77, ; 67
	i32 61, ; 68
	i32 0, ; 69
	i32 6, ; 70
	i32 98, ; 71
	i32 58, ; 72
	i32 42, ; 73
	i32 97, ; 74
	i32 10, ; 75
	i32 5, ; 76
	i32 113, ; 77
	i32 25, ; 78
	i32 71, ; 79
	i32 80, ; 80
	i32 63, ; 81
	i32 102, ; 82
	i32 113, ; 83
	i32 111, ; 84
	i32 81, ; 85
	i32 103, ; 86
	i32 112, ; 87
	i32 59, ; 88
	i32 23, ; 89
	i32 1, ; 90
	i32 53, ; 91
	i32 78, ; 92
	i32 39, ; 93
	i32 120, ; 94
	i32 17, ; 95
	i32 66, ; 96
	i32 9, ; 97
	i32 71, ; 98
	i32 86, ; 99
	i32 81, ; 100
	i32 75, ; 101
	i32 40, ; 102
	i32 29, ; 103
	i32 26, ; 104
	i32 99, ; 105
	i32 8, ; 106
	i32 83, ; 107
	i32 90, ; 108
	i32 35, ; 109
	i32 5, ; 110
	i32 69, ; 111
	i32 0, ; 112
	i32 108, ; 113
	i32 68, ; 114
	i32 4, ; 115
	i32 111, ; 116
	i32 105, ; 117
	i32 52, ; 118
	i32 95, ; 119
	i32 82, ; 120
	i32 46, ; 121
	i32 12, ; 122
	i32 41, ; 123
	i32 40, ; 124
	i32 106, ; 125
	i32 87, ; 126
	i32 102, ; 127
	i32 14, ; 128
	i32 36, ; 129
	i32 8, ; 130
	i32 76, ; 131
	i32 44, ; 132
	i32 18, ; 133
	i32 118, ; 134
	i32 103, ; 135
	i32 116, ; 136
	i32 35, ; 137
	i32 13, ; 138
	i32 10, ; 139
	i32 95, ; 140
	i32 119, ; 141
	i32 43, ; 142
	i32 11, ; 143
	i32 54, ; 144
	i32 20, ; 145
	i32 87, ; 146
	i32 108, ; 147
	i32 63, ; 148
	i32 15, ; 149
	i32 110, ; 150
	i32 56, ; 151
	i32 58, ; 152
	i32 21, ; 153
	i32 45, ; 154
	i32 46, ; 155
	i32 79, ; 156
	i32 27, ; 157
	i32 48, ; 158
	i32 6, ; 159
	i32 61, ; 160
	i32 19, ; 161
	i32 82, ; 162
	i32 79, ; 163
	i32 47, ; 164
	i32 88, ; 165
	i32 118, ; 166
	i32 80, ; 167
	i32 105, ; 168
	i32 94, ; 169
	i32 65, ; 170
	i32 84, ; 171
	i32 34, ; 172
	i32 72, ; 173
	i32 85, ; 174
	i32 120, ; 175
	i32 92, ; 176
	i32 12, ; 177
	i32 73, ; 178
	i32 115, ; 179
	i32 83, ; 180
	i32 59, ; 181
	i32 50, ; 182
	i32 7, ; 183
	i32 104, ; 184
	i32 64, ; 185
	i32 74, ; 186
	i32 24, ; 187
	i32 55, ; 188
	i32 51, ; 189
	i32 62, ; 190
	i32 119, ; 191
	i32 76, ; 192
	i32 3, ; 193
	i32 37, ; 194
	i32 11, ; 195
	i32 93, ; 196
	i32 121, ; 197
	i32 24, ; 198
	i32 23, ; 199
	i32 55, ; 200
	i32 44, ; 201
	i32 31, ; 202
	i32 100, ; 203
	i32 68, ; 204
	i32 28, ; 205
	i32 73, ; 206
	i32 36, ; 207
	i32 121, ; 208
	i32 33, ; 209
	i32 72, ; 210
	i32 96, ; 211
	i32 52, ; 212
	i32 60, ; 213
	i32 90, ; 214
	i32 112, ; 215
	i32 38, ; 216
	i32 109, ; 217
	i32 50, ; 218
	i32 32, ; 219
	i32 89, ; 220
	i32 62, ; 221
	i32 116, ; 222
	i32 75, ; 223
	i32 57, ; 224
	i32 85, ; 225
	i32 27, ; 226
	i32 9, ; 227
	i32 53, ; 228
	i32 101, ; 229
	i32 45, ; 230
	i32 115, ; 231
	i32 47, ; 232
	i32 107, ; 233
	i32 22, ; 234
	i32 17, ; 235
	i32 37, ; 236
	i32 29, ; 237
	i32 70, ; 238
	i32 49, ; 239
	i32 96, ; 240
	i32 43, ; 241
	i32 84, ; 242
	i32 70 ; 243
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
