// Imports
const {utils: Cu} = Components;
Cu.import('resource://gre/modules/XPCOMUtils.jsm');
// XPCOMUtils.defineLazyModuleGetter(this, 'AddonManager', 'resource://gre/modules/AddonManager.jsm');
XPCOMUtils.defineLazyModuleGetter(this, 'NetUtil', 'resource://gre/modules/NetUtil.jsm');
XPCOMUtils.defineLazyModuleGetter(this, 'PlacesUtils', 'resource://gre/modules/PlacesUtils.jsm');
// XPCOMUtils.defineLazyModuleGetter(this, 'PopupNotifications', 'resource://gre/modules/PopupNotifications.jsm');
XPCOMUtils.defineLazyModuleGetter(this, 'Preferences', 'resource://gre/modules/Preferences.jsm');

// Edit about:config
Preferences.set({
  'extensions.VimFx.prevent_autofocus': true,
  // Remove tab close buttons
  'extensions.tabmix.tabs.closeButtons': 2,
  'browser.tabs.animate': false,
  'browser.tabs.closeWindowWithLastTab': false,
  // Restore last sessions
  'browser.startup.page': 3,
  // Force enable e10s
  'extensions.e10sBlockedByAddons': false,
  'extensions.e10sBlocksEnabling': false,
  'dom.ipc.processCount': 4,
});

// Add search engines to bookmarks
let search_engines = [
{keyword: 'gs', title:'Google Search', url: 'https://www.google.com/search?q=%s'},
{keyword: 'gt', title:'Google Translate', url: 'http://translate.google.com/?source=osdd#auto|auto|%s'},
{keyword: 'alc', title:'英辞郎検索', url: 'http://eow.alc.co.jp/search?q=%s'},
];
let bookmarks = PlacesUtils.bookmarks;
search_engines.forEach((element) => {
  let uri = NetUtil.newURI(element.url, null, null);
  if (!bookmarks.isBookmarked(uri)) {
    bookmarks.insertBookmark(
      bookmarks.unfiledBookmarksFolder,
      uri,
      bookmarks.DEFAULT_INDEX,
      element.title);
    PlacesUtils.keywords.insert(element);
  }
});

// Custom commands
let {commands} = vimfx.modes.normal;

vimfx.addCommand({
  name: 'zoom_in',
  description: 'Zoom in',
}, ({vim}) => {
  vim.window.FullZoom.enlarge();
})

vimfx.addCommand({
  name: 'zoom_out',
  description: 'Zoom out',
}, ({vim}) => {
  vim.window.FullZoom.reduce();
});

vimfx.addCommand({
  name: 'reset_the_zoom',
  description: 'Reset the zoom',
}, ({vim}) => {
  vim.window.FullZoom.reset();
});

vimfx.addCommand({
    name: 'goto_tab',
    description: 'Goto tab',
    category: 'tabs',
}, (args) => {
    commands.focus_location_bar.run(args);
    args.vim.window.gURLBar.value = '% ';
});
vimfx.on('TabSelect', ({event}) => {
  event.detail.previousTab.ownerDocument.activeElement.blur();
});

// Key mappings
vimfx.set('mode.normal.go_home', '');
vimfx.set('mode.normal.scroll_left', '');
vimfx.set('mode.normal.scroll_right', '');
vimfx.set('mode.normal.scroll_page_down', '<c-f>');
vimfx.set('mode.normal.scroll_page_up', '<c-b>');
vimfx.set('mode.normal.scroll_half_page_down', '<c-d>');
vimfx.set('mode.normal.scroll_half_page_up', '<c-u>');

vimfx.set('mode.normal.tab_select_previous', 'h');
vimfx.set('mode.normal.tab_select_next', 'l');
vimfx.set('mode.normal.tab_select_most_recent', '');
vimfx.set('mode.normal.tab_move_backward', 'gh');
vimfx.set('mode.normal.tab_move_forward', 'gl');
vimfx.set('mode.normal.tab_close', 'd');
vimfx.set('mode.normal.tab_restore', 'u');
vimfx.set('mode.normal.follow_in_focused_tab', vimfx.getDefault('mode.normal.follow_in_focused_tab') +  ' ;t');

vimfx.set('mode.normal.esc', vimfx.getDefault('mode.normal.esc') + ' <c-[>');
vimfx.set('mode.caret.exit', vimfx.getDefault('mode.caret.exit') +   ' <c-[>');
vimfx.set('mode.hints.exit', vimfx.getDefault('mode.hints.exit') +   ' <c-[>');
vimfx.set('mode.ignore.exit', vimfx.getDefault('mode.ignore.exit') +   ' <c-[>');;
vimfx.set('mode.find.exit', vimfx.getDefault('mode.find.exit') +   ' <c-[>');
vimfx.set('mode.marks.exit', vimfx.getDefault('mode.marks.exit') +   ' <c-[>');

// Custom commands
vimfx.set('custom.mode.normal.zoom_in', 'zi');
vimfx.set('custom.mode.normal.zoom_out', 'zo');
vimfx.set('custom.mode.normal.reset_the_zoom', 'zz');
vimfx.set('custom.mode.normal.goto_tab', 'b');
