/*******************************************************************************
* fred Copyright (c) 2024 by SITS Sarl                                         *
*                                                                              *
* Author(s):                                                                   *
*   Gillen Daniel <development@sits.lu>                                        *
*                                                                              *
* This program is free software: you can redistribute it and/or modify it      *
* under the terms of the GNU General Public License as published by the Free   *
* Software Foundation, either version 3 of the License, or (at your option)    *
* any later version.                                                           *
*                                                                              *
* This program is distributed in the hope that it will be useful, but WITHOUT  *
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or        *
* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for     *
* more details.                                                                *
*                                                                              *
* You should have received a copy of the GNU General Public License along with *
* this program. If not, see <http://www.gnu.org/licenses/>.                    *
*******************************************************************************/

#ifndef REGISTRYNODETREEMODELPROXY_H
#define REGISTRYNODETREEMODELPROXY_H

#include <QSortFilterProxyModel>

class RegistryNodeTreeModelProxy : public QSortFilterProxyModel {
  Q_OBJECT

  public:
    explicit RegistryNodeTreeModelProxy(QObject *p_parent=0);

  protected:
    bool lessThan(const QModelIndex &left, const QModelIndex &right) const;
};

#endif // REGISTRYNODETREEMODELPROXY_H
