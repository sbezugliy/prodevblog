import MainView    from './main';
import PartNewView from './part/new';
import PartEditView from './part/edit';

// Collection of specific view modules
const views = {
  PartNewView,
  PartEditView
};

export default function loadView(viewName) {
  return views[viewName] || MainView;
}
