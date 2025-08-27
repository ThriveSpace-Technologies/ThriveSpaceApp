import { Card, CardContent, CardHeader, CardTitle } from "./ui/card";
import { LineChart, Line, XAxis, YAxis, ResponsiveContainer, Tooltip } from "recharts";

interface OverviewChartProps {
  data: Array<{
    day: string;
    wellness: number;
    activity: number;
    nutrition: number;
  }>;
  title?: string;
}

export function OverviewChart({ data, title = "Weekly Wellness Score" }: OverviewChartProps) {
  const CustomTooltip = ({ active, payload, label }: any) => {
    if (active && payload && payload.length) {
      return (
        <div className="bg-card border border-border rounded-lg p-3 shadow-lg">
          <p className="text-sm font-medium text-foreground mb-2">{label}</p>
          {payload.map((entry: any, index: number) => (
            <div key={index} className="flex items-center space-x-2 text-sm">
              <div 
                className="w-2 h-2 rounded-full" 
                style={{ backgroundColor: entry.color }}
              />
              <span className="text-muted-foreground capitalize">{entry.dataKey}:</span>
              <span className="text-foreground font-medium">{entry.value}%</span>
            </div>
          ))}
        </div>
      );
    }
    return null;
  };

  return (
    <Card className="border-border/50">
      <CardHeader className="pb-3">
        <CardTitle className="text-foreground">{title}</CardTitle>
      </CardHeader>
      <CardContent className="p-0 pb-4">
        <div className="h-48 w-full px-4">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart data={data} margin={{ top: 5, right: 5, left: 5, bottom: 5 }}>
              <XAxis 
                dataKey="day" 
                axisLine={false}
                tickLine={false}
                tick={{ fontSize: 12, fill: 'var(--muted-foreground)' }}
              />
              <YAxis 
                domain={[0, 100]}
                axisLine={false}
                tickLine={false}
                tick={{ fontSize: 12, fill: 'var(--muted-foreground)' }}
              />
              <Tooltip content={<CustomTooltip />} />
              <Line 
                type="monotone" 
                dataKey="wellness" 
                stroke="var(--teal)" 
                strokeWidth={2}
                dot={{ fill: 'var(--teal)', strokeWidth: 0, r: 3 }}
                activeDot={{ r: 4, stroke: 'var(--teal)', strokeWidth: 2, fill: 'var(--background)' }}
              />
              <Line 
                type="monotone" 
                dataKey="activity" 
                stroke="var(--purple)" 
                strokeWidth={2}
                dot={{ fill: 'var(--purple)', strokeWidth: 0, r: 3 }}
                activeDot={{ r: 4, stroke: 'var(--purple)', strokeWidth: 2, fill: 'var(--background)' }}
              />
              <Line 
                type="monotone" 
                dataKey="nutrition" 
                stroke="var(--chart-3)" 
                strokeWidth={2}
                dot={{ fill: 'var(--chart-3)', strokeWidth: 0, r: 3 }}
                activeDot={{ r: 4, stroke: 'var(--chart-3)', strokeWidth: 2, fill: 'var(--background)' }}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
        
        {/* Legend */}
        <div className="flex items-center justify-center space-x-6 pt-3 px-4">
          <div className="flex items-center space-x-2">
            <div className="w-3 h-3 rounded-full bg-teal" />
            <span className="text-sm text-muted-foreground">Wellness</span>
          </div>
          <div className="flex items-center space-x-2">
            <div className="w-3 h-3 rounded-full bg-purple" />
            <span className="text-sm text-muted-foreground">Activity</span>
          </div>
          <div className="flex items-center space-x-2">
            <div className="w-3 h-3 rounded-full" style={{ backgroundColor: 'var(--chart-3)' }} />
            <span className="text-sm text-muted-foreground">Nutrition</span>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}