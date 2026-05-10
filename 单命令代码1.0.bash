cat > /www/luci-static/argon/album.htm << 'EOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>iStoreOS-登入背景管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --dark-primary: #483d8b;
            --bg: #1e1e1e;
            --card: #252526;
            --text: #cccccc;
            --text2: #aaaaaa;
        }
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: system-ui, -apple-system, sans-serif;
        }
        body {
            background: var(--bg);
            color: var(--text);
            padding: 20px;
            margin: 0;
        }
        .container {
            max-width: 1600px;
            margin: 0 auto;
        }
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 12px;
        }
        .page-title {
            font-size: 22px;
            color: #fff;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .back-btn {
            background: #333;
            color: #fff;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }
        .view-tabs {
            display: flex;
            gap: 8px;
        }
        .view-tabs button {
            background: #333;
            color: var(--text);
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }
        .view-tabs button.active {
            background: var(--dark-primary);
            color: #fff;
        }
        .upload-box {
            background: var(--card);
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }
        .upload-box input {
            background: #333;
            color: #fff;
            border: 1px solid #444;
            padding: 8px 12px;
            border-radius: 6px;
            outline: none;
        }
        .upload-box button {
            background: var(--dark-primary);
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
        }
        .upload-box button:hover {
            opacity: 0.9;
        }
        .tip {
            font-size: 12px;
            color: #888;
            margin-top: 16px;
            line-height: 1.4;
        }

        .grid-view {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 16px;
        }
        .card {
            background: var(--card);
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.2s;
            cursor: pointer;
        }
        .card:hover {
            transform: translateY(-3px);
        }
        .card-img {
            width: 100%;
            height: 140px;
            object-fit: cover;
            display: block;
        }
        .card-info {
            padding: 12px;
        }
        .card-name {
            font-weight: 500;
            margin-bottom: 4px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .card-size, .card-res {
            font-size: 12px;
            color: var(--text2);
            margin-bottom: 4px;
        }
        .card-btns {
            display: flex;
            gap: 6px;
            margin-top: 10px;
        }
        .card-btns a, .card-btns button {
            flex: 1;
            text-align: center;
            padding: 6px 0;
            border-radius: 4px;
            font-size: 13px;
            text-decoration: none;
            border: none;
            cursor: pointer;
        }
        .btn-preview { background: #333; color: #fff; }
        .btn-delete { background: #c45c00; color: #fff; }

        .list-view {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .list-item {
            background: var(--card);
            padding: 12px 16px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }
        .list-left {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 0;
            flex: 1;
        }
        .list-thumb {
            width: 48px;
            height: 48px;
            object-fit: cover;
            border-radius: 6px;
            flex-shrink: 0;
        }
        .list-info {
            min-width: 0;
        }
        .list-name {
            font-weight: 500;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .list-meta {
            font-size: 12px;
            color: var(--text2);
            margin-top: 4px;
            display: flex;
            gap: 12px;
        }
        .list-btns {
            display: flex;
            gap: 8px;
            flex-shrink: 0;
        }
        .list-btns a, .list-btns button {
            padding: 6px 10px;
            border-radius: 4px;
            font-size: 13px;
            border: none;
            cursor: pointer;
        }

        .preview-modal {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.9);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            padding: 20px;
            flex-direction: column;
        }
        .preview-modal.show {
            display: flex;
        }
        .preview-img {
            max-width: 90%;
            max-height: 75vh;
            border-radius: 8px;
            box-shadow: 0 0 30 rgba(0,0,0,0.5);
            object-fit: contain;
        }
        .preview-nav {
            display: flex;
            justify-content: space-between;
            width: 100%;
            max-width: 700px;
            margin-top: 20px;
            gap: 10px;
        }
        .preview-nav button {
            background: #222;
            color: #fff;
            border: none;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            font-size: 20px;
            cursor: pointer;
        }
        .preview-info {
            color: #fff;
            text-align: center;
            margin-top: 15px;
            line-height: 1.6;
        }
        .preview-close {
            position: absolute;
            top: 20px;
            right: 20px;
            background: #222;
            color: #fff;
            border: none;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            font-size: 20px;
            cursor: pointer;
        }
        .login-tip {
            background: #252526;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            margin-top: 50px;
        }
        .login-tip h2 {
            color: #fff;
            margin-bottom: 15px;
        }
        .login-tip p {
            margin-bottom: 20px;
        }
        .login-btn {
            background: #483d8b;
            color: #fff;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
        }
        @media (max-width: 768px) {
            .grid-view {
                grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
                gap: 12px;
            }
            .card-img {
                height: 120px;
            }
            .page-title {
                font-size: 18px;
            }
            .preview-close {
                width: 36px;
                height: 36px;
            }
            .preview-nav button {
                width: 42px;
                height: 42px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div id="page-content">
        <div class="page-header">
            <h1 class="page-title">
                🖼️ iStoreOS-登入背景管理
                <button class="back-btn" onclick="goBack()">返回 Argon 主题设置</button>
            </h1>
            <div class="view-tabs">
                <button id="btn-grid" class="active">相册模式</button>
                <button id="btn-list">文件夹模式</button>
            </div>
        </div>

        <div class="upload-box">
            <input type="file" id="file" accept="image/jpeg,image/png,image/gif,image/webp,video/mp4,video/webm">
            <button onclick="uploadFile()">上传背景文件</button>
        </div>

        <div id="content" class="grid-view"></div>

        <div class="tip">
            存放路径：/www/luci-static/argon/background/<br>
            支持格式：jpg、png、gif、webp、mp4、webm
        </div>
    </div>
</div>

<div class="preview-modal" id="modal">
    <button class="preview-close" onclick="closePreview()">×</button>
    <img src="" id="preview-img" class="preview-img">
    <div class="preview-info" id="preview-info"></div>
    <div class="preview-nav">
        <button id="prev-btn" onclick="prevImg()">←</button>
        <button id="next-btn" onclick="nextImg()">→</button>
    </div>
</div>

<script>
// ===================== 自动路由地址，无需固定IP ======================
const LOGIN_URL = "/cgi-bin/luci";
// ====================================================================

const basePath = "/luci-static/argon/background/";
const ignoreList = ["README.md", "manifest.json", "favicon-", "apple-icon-", "android-icon-", "ms-icon-", "default.jpg", "login-bg.jpg"];

let currentView = "grid";
let fileList = [];
let currentIndex = 0;
let fileInfoCache = {};

async function checkLogin() {
    try {
        const r = await fetch("/cgi-bin/luci/admin/", { cache: "no-store" });
        if (r.url.includes("login")) { showLoginTip(); return false; }
        return true;
    } catch(e) { showLoginTip(); return false; }
}

function showLoginTip() {
    document.body.innerHTML = `<div class="container"><div class="login-tip"><h2>🔒 请先登录路由器</h2><p>您尚未登录或会话已过期</p><a href="${LOGIN_URL}" class="login-btn">前往登录</a></div></div>`;
}

// 自动返回 Argon 主题设置，不固定IP
function goBack() {
    window.location.href = "/cgi-bin/luci/admin/system/argon-config";
}

async function getToken() {
    const r = await fetch("/cgi-bin/luci/admin/system/argon-config");
    const m = (await r.text()).match(/name="token" value="([a-f0-9]+)"/);
    return m ? m[1] : "";
}

document.getElementById("btn-grid").onclick = () => { currentView="grid"; document.getElementById("content").className="grid-view"; render(); };
document.getElementById("btn-list").onclick = () => { currentView="list"; document.getElementById("content").className="list-view"; render(); };

async function loadFiles() {
    if (!await checkLogin()) return;
    const el = document.getElementById("content");
    el.innerHTML = "加载中...";
    const r = await fetch("/cgi-bin/luci/admin/system/argon-config");
    const html = await r.text();
    const all = [];
    const reg = /([^"\s]+?\.(jpg|jpeg|png|gif|webp|mp4|webm))/gi;
    let m;
    while ((m = reg.exec(html)) !== null) {
        const name = m[1];
        if (!ignoreList.some(i => name.includes(i)) && !all.includes(name)) all.push(name);
    }
    fileList = all;
    render();
}

function render() {
    const c = document.getElementById("content");
    c.innerHTML = fileList.length === 0 ? `<div style="padding:30px;text-align:center">暂无文件</div>` : "";
    fileList.forEach((f,i) => c.appendChild(currentView==="grid"?makeCard(f,i):makeListItem(f,i)));
}

function makeCard(file, idx) {
    const isImg = !file.endsWith("mp4") && !file.endsWith("webm");
    const card = document.createElement("div");
    card.className = "card";
    const media = document.createElement(isImg?"img":"video");
    media.className = "card-img";
    media.src = basePath+file;
    if (!isImg) { media.muted=true; media.loop=true; media.playsInline=true; }
    media.onclick = () => openPreview(idx);
    const info = document.createElement("div");
    info.className = "card-info";
    const name = document.createElement("div");
    name.className = "card-name";
    name.textContent = file;
    const size = document.createElement("div");
    size.className = "card-size";
    const res = document.createElement("div");
    res.className = "card-res";
    const btns = document.createElement("div");
    btns.className = "card-btns";
    const prev = document.createElement("a");
    prev.className = "btn-preview";
    prev.target="_blank";
    prev.href=basePath+file;
    prev.textContent="预览";
    prev.onclick=e=>e.stopPropagation();
    const del = document.createElement("button");
    del.className="btn-delete";
    del.textContent="删除";
    del.onclick=e=>{e.stopPropagation();deleteFile(file,idx+1);};
    btns.append(prev,del);
    info.append(name,size,res,btns);
    card.append(media,info);
    if (isImg) {
        media.onload=()=>{res.textContent=`${media.naturalWidth}×${media.naturalHeight}`;fileInfoCache[file]={w:media.naturalWidth,h:media.naturalHeight};};
    } else { res.textContent="视频"; }
    fetch(basePath+file,{method:"HEAD"}).then(r=>{const s=r.headers.get("content-length");size.textContent=(s/1024).toFixed(1)+"KB";fileInfoCache[file].size=(s/1024).toFixed(1)+"KB";});
    return card;
}

function makeListItem(file) {
    const isImg = !file.endsWith("mp4") && !file.endsWith("webm");
    const item = document.createElement("div");
    item.className="list-item";
    const left = document.createElement("div");
    left.className="list-left";
    const thumb = document.createElement(isImg?"img":"video");
    thumb.className="list-thumb";
    thumb.src=basePath+file;
    if (!isImg) { thumb.muted=true; thumb.loop=true; thumb.playsInline=true; }
    const info = document.createElement("div");
    info.className="list-info";
    const name = document.createElement("div");
    name.className="list-name";
    name.textContent=file;
    const meta = document.createElement("div");
    meta.className="list-meta";
    const sizeSpan = document.createElement("span");
    const resSpan = document.createElement("span");
    meta.append(sizeSpan,resSpan);
    info.append(name,meta);
    left.append(thumb,info);
    const btns = document.createElement("div");
    btns.className="list-btns";
    const prev = document.createElement("a");
    prev.className="btn-preview";
    prev.target="_blank";
    prev.href=basePath+file;
    prev.textContent="预览";
    const del = document.createElement("button");
    del.className="btn-delete";
    del.textContent="删除";
    del.onclick=()=>deleteFile(file,fileList.indexOf(file)+1);
    btns.append(prev,del);
    item.append(left,btns);
    if (isImg) {
        thumb.onload=()=>{resSpan.textContent=`${thumb.naturalWidth}×${thumb.naturalHeight}`;fileInfoCache[file]={w:thumb.naturalWidth,h:thumb.naturalHeight};};
    } else { resSpan.textContent="视频"; }
    fetch(basePath+file,{method:"HEAD"}).then(r=>{const s=r.headers.get("content-length");sizeSpan.textContent=(s/1024).toFixed(1)+"KB";fileInfoCache[file].size=(s/1024).toFixed(1)+"KB";});
    return item;
}

async function uploadFile() {
    if (!await checkLogin()) return;
    const inp=document.getElementById("file");
    if (!inp.files.length) return alert("请选择文件");
    const fd=new FormData();
    fd.append("ulfile",inp.files[0]);
    fd.append("upload","上传");
    fd.append("cbi.submit","1");
    fd.append("token",await getToken());
    const btn=document.querySelector(".upload-box button");
    btn.textContent="上传中...";
    btn.disabled=true;
    await fetch("/cgi-bin/luci/admin/system/argon-config",{method:"POST",body:fd});
    alert("上传成功！");
    inp.value="";
    btn.textContent="上传背景文件";
    btn.disabled=false;
    loadFiles();
}

// ===================== 完全沿用你原来能触发删除的格式 =====================
async function deleteFile(file, line) {
    if (!await checkLogin()) return;
    if (!confirm("确定删除："+file+"？")) return;

    const token = await getToken();
    await fetch("/cgi-bin/luci/admin/system/argon-config", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `token=${token}&cbi.submit=1&cbid.table.${line}.remove=移除&cbid.table.${line}.name=${encodeURIComponent(file)}`
    });

    loadFiles();
}
// ======================================================================

function openPreview(idx) {
    currentIndex=idx;
    showImg();
    document.getElementById("modal").classList.add("show");
}

function showImg() {
    const f=fileList[currentIndex];
    const img=document.getElementById("preview-img");
    img.src=basePath+f;
    const inf=fileInfoCache[f]||{};
    document.getElementById("preview-info").innerHTML=`文件名：${f}<br>大小：${inf.size||"未知"} | 分辨率：${inf.w?inf.w+"×"+inf.h:"视频"}`;
}

function prevImg() { currentIndex=(currentIndex-1+fileList.length)%fileList.length; showImg(); }
function nextImg() { currentIndex=(currentIndex+1)%fileList.length; showImg(); }
function closePreview() { document.getElementById("modal").classList.remove("show"); }

document.getElementById("modal").onclick=(e)=>{if(e.target===document.getElementById("modal"))closePreview();};
document.addEventListener("keydown",(e)=>{if(document.getElementById("modal").classList.contains("show")){if(e.key==="ArrowLeft")prevImg();if(e.key==="ArrowRight")nextImg();if(e.key==="Escape")closePreview();}});

window.onload=loadFiles;
</script>
</body>
</html>
EOF

chmod 755 /www/luci-static/argon/album.htm
chmod 777 /www/luci-static/argon/background/
rm -rf /tmp/luci-*
/etc/init.d/uhttpd restart
