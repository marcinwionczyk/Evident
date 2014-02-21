using System;
using System.ComponentModel;

namespace EVident.Code
{
    /// <summary>
    /// Klasa ułatwiająca konwersję ListViewDataItem.DataItem na Entity (Installation, InstallationKind 
    /// czy co tam chcecie). Wykorzystuję to w funkcjach ListView ItemDataBound
    /// </summary>
    /// <see cref="http://stackoverflow.com/questions/6502774/unable-to-cast-object-of-type-system-web-ui-webcontrols-entitydatasourcewrapper"/>
    public static class EntityDataSourceExtensions
    {
        public static TEntity GetEntityAs<TEntity>(this object dataItem) where TEntity : class
        {
            var entity = dataItem as TEntity;
            if (entity != null)
                return entity;
            var td = dataItem as ICustomTypeDescriptor;
            return td != null ? (TEntity) td.GetPropertyOwner(null) : null;
        }

        public static Object GetEntity(this object dataItem)
        {
            var td = dataItem as ICustomTypeDescriptor;
            return td != null ? td.GetPropertyOwner(null) : null;
        }
    }
}