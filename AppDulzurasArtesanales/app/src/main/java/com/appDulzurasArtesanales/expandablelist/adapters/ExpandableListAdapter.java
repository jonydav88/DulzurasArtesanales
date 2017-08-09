package com.appDulzurasArtesanales.expandablelist.adapters;

        import java.util.List;
        import java.util.List;
        import java.util.Map;

        import com.appDulzurasArtesanales.expandablelist.adapters.ExpandableListAdapter;

        import android.app.Activity;
        import android.app.AlertDialog;
        import android.content.Context;
        import android.content.DialogInterface;
        import android.graphics.Typeface;
        import android.util.Log;
        import android.view.LayoutInflater;
        import android.view.View;
        import android.view.View.OnClickListener;
        import android.view.ViewGroup;
        import android.widget.BaseExpandableListAdapter;
        import android.widget.ImageView;
        import android.widget.TextView;
        import com.example.jmarquez.appdulzurasartesanales.R;

public class ExpandableListAdapter extends BaseExpandableListAdapter
{
    private Activity context;
    private Map<String, List<String>> MenuCollections;
    private List<String> MenuItem;

    public ExpandableListAdapter(Activity context, List<String> MenuItems, Map<String, List<String>> itemCollections)
    {
        this.context = context;
        this.MenuCollections = itemCollections;
        this.MenuItem = MenuItems;
    }

        public Object getChild(int groupPosition, int childPosition)
        {return MenuCollections.get(MenuItem.get(groupPosition)).get(childPosition);}

        public long getChildId(int groupPosition, int childPosition) {return childPosition;}

        public View getChildView(final int groupPosition, final int childPosition,
            boolean isLastChild, View convertView, ViewGroup parent)
        {
            final String MenuItem = (String) getChild(groupPosition, childPosition);
            LayoutInflater inflater = context.getLayoutInflater();

            if (convertView == null)
            {
                convertView = inflater.inflate(R.layout.child_item, null);
            }

            TextView item = (TextView) convertView.findViewById(R.id.laptop);

            /*ImageView delete = (ImageView) convertView.findViewById(R.id.delete);
            delete.setOnClickListener(new OnClickListener() {

            public void onClick(View v)
            {
                    AlertDialog.Builder builder = new AlertDialog.Builder(context);
                    builder.setMessage("Do you want to remove?");
                    builder.setCancelable(false);
                    builder.setPositiveButton("Yes",new DialogInterface.OnClickListener()
                            {
                                    public void onClick(DialogInterface dialog, int id)
                                    {
                                        List<String> child = laptopCollections.get(laptops.get(groupPosition));
                                        child.remove(childPosition);
                                        notifyDataSetChanged();
                                    }
                            });
                    builder.setNegativeButton("No",new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                            dialog.cancel();
                            }
                        });
                    AlertDialog alertDialog = builder.create();
                    alertDialog.show();
                }
            });*/

            item.setText(MenuItem);
            return convertView;
        }

        public int getChildrenCount(int groupPosition) {return MenuCollections.get(MenuItem.get(groupPosition)).size();}

        public Object getGroup(int groupPosition) {return MenuItem.get(groupPosition);}

        public int getGroupCount() {return MenuItem.size();}

        public long getGroupId(int groupPosition) {return groupPosition;}

        public View getGroupView(int groupPosition, boolean isExpanded,
        View convertView, ViewGroup parent)
        {
            String laptopName = (String) getGroup(groupPosition);
            if (convertView == null) {
            LayoutInflater infalInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            convertView = infalInflater.inflate(R.layout.group_item, null);
            }
            TextView item = (TextView) convertView.findViewById(R.id.laptop);
            item.setTypeface(null, Typeface.BOLD);
            item.setText(laptopName);
            return convertView;
        }

        public boolean hasStableIds() {return true;}

        public boolean isChildSelectable(int groupPosition, int childPosition) {return true;}
}